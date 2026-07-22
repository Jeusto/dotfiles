# ~/.config/zsh/claude-shell.zsh — natural-language command assistant powered by Claude
# Source this from your ~/.zshrc:   source ~/.claude-shell.zsh
#
# Provides:
#   Ctrl-G           widget: turn the current line (natural language OR a broken
#                    command) into a shell command, in place. Enter to run,
#                    edit/Ctrl-C to reject.
#   ai <request>     print a suggested command onto the next prompt (accept/edit/reject)
#   fix [cmd]        fix/improve your last command (or the given one; reads piped
#                    error output as extra context if present)
#
# Speed: the `claude` CLI has a ~3s cold-start floor (Node boot + auth), so the
# model barely affects latency. For a sub-second path, export an API key:
#   export ANTHROPIC_API_KEY=sk-ant-...   # then this uses curl instead of the CLI
#
# Config (export before sourcing):
#   CLAUDE_CMD_MODEL       CLI model alias      (default: haiku)
#   CLAUDE_CMD_API_MODEL   API model id         (default: claude-haiku-4-5-20251001)

: ${CLAUDE_CMD_MODEL:=haiku}
: ${CLAUDE_CMD_API_MODEL:=claude-haiku-4-5-20251001}

_CLAUDE_CMD_SYS='You translate a request into a single shell command for macOS zsh.
Rules:
- Output ONLY the command. No explanation, no markdown, no code fences, no backticks, no leading $ or #.
- Prefer one line; use && or ; to chain when needed.
- If the input is already a shell command that is broken or could be improved, output a corrected/improved version instead.
- Prefer standard macOS/BSD tools and widely-installed CLIs.
- If you truly cannot produce a command, output exactly: echo "Claude: could not determine a command"'

# Shared loading/feedback states, used by every entry point (widget + functions).
_CLAUDE_SPIN=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
_CLAUDE_THINKING='Claude thinking…'            # spinner caption
_CLAUDE_MSG_NONE='Claude: no suggestion'       # empty-result message
_CLAUDE_SPIN_MS=0.08                           # frame delay (seconds)

# Strip code fences / leading blank lines the model might emit.
_claude_strip() {
  awk 'BEGIN{started=0}
       /^[[:space:]]*```/ {next}
       !started && /^[[:space:]]*$/ {next}
       {started=1; print}' \
  | sed -e 's/^[[:space:]]*\$[[:space:]]//'
}

# --- Fast path: direct API call via curl (used only if ANTHROPIC_API_KEY set) ---
_claude_cmd_gen_api() {
  local payload
  payload=$(jq -n --arg m "$CLAUDE_CMD_API_MODEL" --arg sys "$_CLAUDE_CMD_SYS" --arg u "$1" \
    '{model:$m, max_tokens:400, system:$sys, messages:[{role:"user",content:$u}]}')
  curl -sS https://api.anthropic.com/v1/messages \
    -H "x-api-key: $ANTHROPIC_API_KEY" \
    -H "anthropic-version: 2023-06-01" \
    -H "content-type: application/json" \
    -d "$payload" 2>/dev/null \
  | jq -r '.content[0].text // empty' 2>/dev/null | _claude_strip
}

# --- Fallback path: the claude CLI (tools disabled -> pure text, never executes) ---
_claude_cmd_gen_cli() {
  command claude -p --no-session-persistence \
    --model "$CLAUDE_CMD_MODEL" \
    --disallowedTools Bash Edit Write Read Glob Grep Task WebFetch WebSearch TodoWrite NotebookEdit \
    --append-system-prompt "$_CLAUDE_CMD_SYS" \
    -- "$1" 2>/dev/null | _claude_strip
}

# request string -> command string on stdout.
_claude_cmd_gen() {
  if [[ -n $ANTHROPIC_API_KEY ]] && command -v jq >/dev/null 2>&1 && command -v curl >/dev/null 2>&1; then
    _claude_cmd_gen_api "$1"
  elif command -v claude >/dev/null 2>&1; then
    _claude_cmd_gen_cli "$1"
  else
    print -u2 "claude-shell: need either ANTHROPIC_API_KEY (+curl+jq) or the 'claude' CLI"
    return 1
  fi
}

# Run generation in the background with an animated spinner on stderr; echo result.
_claude_cmd_gen_spin() {
  local tmp; tmp=$(mktemp)
  ( _claude_cmd_gen "$1" >| "$tmp" ) &!
  local pid=$! i=1
  while kill -0 $pid 2>/dev/null; do
    printf '\r\033[K\033[36m%s\033[0m %s' "${_CLAUDE_SPIN[i]}" "$_CLAUDE_THINKING" >&2
    i=$(( i % ${#_CLAUDE_SPIN} + 1 ))
    sleep $_CLAUDE_SPIN_MS
  done
  printf '\r\033[K' >&2
  cat "$tmp"; rm -f "$tmp"
}

# ---- ZLE widget: transform the current command line in place (animated) ----
_claude_line_widget() {
  emulate -L zsh
  local input=$BUFFER
  if [[ -z ${input//[[:space:]]/} ]]; then
    zle -M "Claude: type a request (or a command to fix) first"
    return 0
  fi
  local tmp; tmp=$(mktemp)
  ( _claude_cmd_gen "$input" >| "$tmp" ) &!
  local pid=$! i=1
  while kill -0 $pid 2>/dev/null; do
    zle -M "${_CLAUDE_SPIN[i]} ${_CLAUDE_THINKING}"
    zle -R
    i=$(( i % ${#_CLAUDE_SPIN} + 1 ))
    sleep $_CLAUDE_SPIN_MS
  done
  local out; out="$(<$tmp)"; rm -f "$tmp"
  if [[ -n ${out//[[:space:]]/} ]]; then
    BUFFER="$out"; CURSOR=${#BUFFER}
    zle -M ""
  else
    zle -M "$_CLAUDE_MSG_NONE (is 'claude' installed and logged in?)"
  fi
  zle reset-prompt
}
zle -N _claude_line_widget
bindkey '^g' _claude_line_widget   # Ctrl-G. Change to taste, e.g. bindkey '^[i' ...

# ---- ai: print a suggestion onto the next prompt line ----
ai() {
  if [[ -z "$*" ]]; then
    print -u2 "usage: ai <what you want to do>"
    return 1
  fi
  local out; out="$(_claude_cmd_gen_spin "$*")"
  [[ -z ${out//[[:space:]]/} ]] && { print -u2 "$_CLAUDE_MSG_NONE"; return 1; }
  print -z -- "$out"
}

# ---- fix: correct/improve the last (or given) command ----
fix() {
  local target
  # `builtin fc` so the user's `alias fc=fzf...` can't hijack history lookup.
  if (( $# )); then target="$*"; else target="$(builtin fc -ln -1)"; fi
  [[ -z ${target//[[:space:]]/} ]] && { print -u2 "fix: nothing to fix"; return 1; }

  local ctx=""
  [[ ! -t 0 ]] && ctx="$(cat)"

  local req="Correct or improve this shell command. Output only the fixed command.
COMMAND: $target"
  [[ -n $ctx ]] && req+="
ERROR OR OUTPUT:
$ctx"

  local out; out="$(_claude_cmd_gen_spin "$req")"
  [[ -z ${out//[[:space:]]/} ]] && { print -u2 "$_CLAUDE_MSG_NONE"; return 1; }
  print -z -- "$out"
}

