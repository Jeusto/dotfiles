# ~/.config/zsh/claude-shell.zsh — natural-language command assistant powered by Claude
# Sourced from ~/.zshrc:   source $HOME/.config/zsh/claude-shell.zsh
#
# Provides:
#   Ctrl-G           widget: turn the current line (natural language OR a broken
#                    command) into a shell command, in place. Enter to run,
#                    edit/Ctrl-C to reject.
#   ai <request>     print a suggested command onto the next prompt (accept/edit/reject)
#   fix [cmd]        fix/improve your last command (or the given one; reads piped
#                    error output as extra context if present)
#   wtf              explain why the last command failed and offer a fix. Re-runs
#                    the command to capture its output, unless it looks like it
#                    changes something — see `wtf --help`.
#
# Speed: the `claude` CLI has a ~3s cold-start floor (Node boot + auth), so the
# model barely affects latency. For a sub-second path, export an API key:
#   export ANTHROPIC_API_KEY=sk-ant-...   # then this uses curl instead of the CLI
#
# Config (export before sourcing):
#   CLAUDE_CMD_MODEL       CLI model alias      (default: haiku)
#   CLAUDE_CMD_API_MODEL   API model id         (default: claude-haiku-4-5-20251001)
#   NO_COLOR               set to disable all styling

: ${CLAUDE_CMD_MODEL:=haiku}
: ${CLAUDE_CMD_API_MODEL:=claude-haiku-4-5-20251001}

# ---------------------------------------------------------------- styling ----

_claude_style() {
  if [[ -t 2 && -z $NO_COLOR ]]; then
    _CLAUDE_BOLD=$'\e[1m'; _CLAUDE_DIM=$'\e[2m';    _CLAUDE_RED=$'\e[31m'
    _CLAUDE_GRN=$'\e[32m'; _CLAUDE_YEL=$'\e[33m';   _CLAUDE_CYA=$'\e[36m'
    _CLAUDE_OFF=$'\e[0m'
  else
    _CLAUDE_BOLD=''; _CLAUDE_DIM=''; _CLAUDE_RED=''
    _CLAUDE_GRN='';  _CLAUDE_YEL=''; _CLAUDE_CYA=''
    _CLAUDE_OFF=''
  fi
}
_claude_style

_CLAUDE_SPIN=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
_CLAUDE_THINKING='thinking'
_CLAUDE_MSG_NONE='no suggestion'
_CLAUDE_SPIN_MS=0.08

# A labelled, wrapped field:  "  why   some long explanation that folds nicely"
_claude_field() {
  local label=$1 color=$2 text=$3
  # COLUMNS is unset or nonsense when there is no terminal attached
  local cols=${COLUMNS:-0}
  (( cols < 40 )) && cols=80
  local width=$(( cols - 9 ))

  print -r -- "$text" | fold -s -w $width | {
    local first=1 line
    while IFS= read -r line; do
      if (( first )); then
        printf '  %s%-5s%s %s\n' "$color" "$label" "$_CLAUDE_OFF" "$line"
        first=0
      else
        printf '        %s\n' "$line"
      fi
    done
  }
}

_claude_note() {
  printf '  %s%s%s\n' "$_CLAUDE_DIM" "$1" "$_CLAUDE_OFF" >&2
}

_claude_err() {
  printf '  %s✖%s %s\n' "$_CLAUDE_RED" "$_CLAUDE_OFF" "$1" >&2
}

# --------------------------------------------------------------- prompts -----

_CLAUDE_CMD_SYS='You translate a request into a single shell command for macOS zsh.
Your entire response is pasted straight onto the user'"'"'s command line, so it must be
runnable text and nothing else.

Rules:
- Output ONLY the command. No explanation, no commentary, no preamble, no trailing
  notes, no markdown, no code fences, no backticks, no leading $ or #.
- NEVER ask a question. NEVER reply with prose. NEVER say the request is ambiguous,
  unclear, risky, or that you need more information. There is no conversation here:
  the user cannot answer you, and any non-command text just has to be deleted by hand.
- If details are missing, DO NOT ask - commit to the most likely interpretation and
  emit the command anyway. Where a value genuinely cannot be guessed, inline an
  obvious ALL-CAPS placeholder the user can overwrite (<FILE>, <DIR>, <BRANCH>,
  <PORT>, <PATTERN>) rather than refusing or explaining.
- A best guess with placeholders always beats a question or a caveat. Guess.
- Prefer one line; use && or ; to chain when needed.
- If the input is already a shell command that is broken or could be improved, output a corrected/improved version instead.
- Prefer standard macOS/BSD tools and widely-installed CLIs.
- Destructive commands (rm, kill, dd, git reset --hard, ...) are fine to emit when
  asked - the user reviews the line before pressing Enter. Do not warn, do not soften,
  do not add a safety flag that was not requested.
- Only if the request maps to no command at all, output exactly:
  echo "Claude: could not determine a command"'

_CLAUDE_WTF_SYS='You diagnose a failed shell command on macOS zsh.

Reply in EXACTLY this format and nothing else:
WHY: <1-3 sentences naming the actual cause>
CMD: <one corrected shell command, or the word NONE>

Rules:
- WHY explains the underlying cause. Do not merely restate the error text back.
- Be concrete: name the missing binary, the wrong flag, the bad path, the exit code
  meaning. If the output is truncated or absent, reason from the command itself and
  say what you are assuming.
- CMD must be runnable as-is on macOS zsh. No markdown, no fences, no leading $.
- Use ALL-CAPS placeholders (<FILE>, <BRANCH>) only where a value truly cannot be guessed.
- Use CMD: NONE when no single command would fix it - for example when the user must
  choose between real alternatives, or the fix is to edit a file.
- Never ask a question. Never add keys beyond WHY and CMD.

When OUTPUT is "(unavailable)" you have NOT seen the error. You are working from the
command text alone, which is rarely enough:
- Begin WHY with "Without the error text, most likely: ".
- Give the single most likely cause, phrased as likely, never as fact.
- Never invent specifics you cannot know - no exit-code meanings, no file names, no
  claims about what is or is not staged, installed, running or configured.
- If the command commonly fails for several unrelated reasons, say that instead of
  picking one.'

# --------------------------------------------------------------- backend -----

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
  payload=$(jq -n --arg m "$CLAUDE_CMD_API_MODEL" --arg sys "$2" --arg u "$1" \
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
    --append-system-prompt "$2" \
    -- "$1" 2>/dev/null | _claude_strip
}

# request string [system prompt] -> text on stdout.
_claude_cmd_gen() {
  local req=$1 sys=${2:-$_CLAUDE_CMD_SYS}
  if [[ -n $ANTHROPIC_API_KEY ]] && command -v jq >/dev/null 2>&1 && command -v curl >/dev/null 2>&1; then
    _claude_cmd_gen_api "$req" "$sys"
  elif command -v claude >/dev/null 2>&1; then
    _claude_cmd_gen_cli "$req" "$sys"
  else
    _claude_err "need either ANTHROPIC_API_KEY (+curl+jq) or the 'claude' CLI"
    return 1
  fi
}

# Run generation in the background behind a spinner with a running clock.
_claude_cmd_gen_spin() {
  local req=$1 sys=$2 caption=${3:-$_CLAUDE_THINKING}
  # nothing to animate on: run it inline. (The job below is disowned with &!, so
  # it cannot be wait'ed for — only polled — and polling without a tty is pointless.)
  if [[ ! -t 2 ]]; then
    _claude_cmd_gen "$req" "$sys"
    return
  fi

  local tmp; tmp=$(mktemp)
  ( _claude_cmd_gen "$req" "$sys" >| "$tmp" ) &!
  local pid=$! i=1 n=0
  while kill -0 $pid 2>/dev/null; do
    printf '\r\e[K  %s%s%s %s%s %.1fs%s' \
      "$_CLAUDE_CYA" "${_CLAUDE_SPIN[i]}" "$_CLAUDE_OFF" \
      "$_CLAUDE_DIM" "$caption" "$(( n * _CLAUDE_SPIN_MS ))" "$_CLAUDE_OFF" >&2
    i=$(( i % ${#_CLAUDE_SPIN} + 1 )); n=$(( n + 1 ))
    sleep $_CLAUDE_SPIN_MS
  done
  printf '\r\e[K' >&2
  cat "$tmp"; rm -f "$tmp"
}

# ------------------------------------------------------------ ZLE widget -----

# Transform the current command line in place (animated).
_claude_line_widget() {
  emulate -L zsh
  local input=$BUFFER
  if [[ -z ${input//[[:space:]]/} ]]; then
    zle -M "  type a request (or a command to fix) first"
    return 0
  fi
  local tmp; tmp=$(mktemp)
  ( _claude_cmd_gen "$input" >| "$tmp" ) &!
  local pid=$! i=1 n=0
  while kill -0 $pid 2>/dev/null; do
    zle -M "  ${_CLAUDE_SPIN[i]} ${_CLAUDE_THINKING} $(printf '%.1f' $(( n * _CLAUDE_SPIN_MS )))s"
    zle -R
    i=$(( i % ${#_CLAUDE_SPIN} + 1 )); n=$(( n + 1 ))
    sleep $_CLAUDE_SPIN_MS
  done
  local out; out="$(<$tmp)"; rm -f "$tmp"
  if [[ -n ${out//[[:space:]]/} ]]; then
    BUFFER="$out"; CURSOR=${#BUFFER}
    zle -M ""
  else
    zle -M "  $_CLAUDE_MSG_NONE (is 'claude' installed and logged in?)"
  fi
  zle reset-prompt
}
zle -N _claude_line_widget
bindkey '^g' _claude_line_widget   # Ctrl-G. Change to taste, e.g. bindkey '^[i' ...

# ------------------------------------------------------------- ai / fix ------

# Put a command on the next prompt, with a hint line above it.
_claude_offer() {
  printf '  %s⏎ to run · edit it · ⌃C to discard%s\n' "$_CLAUDE_DIM" "$_CLAUDE_OFF" >&2
  print -z -- "$1"
}

# ---- ai: print a suggestion onto the next prompt line ----
ai() {
  if [[ -z "$*" ]]; then
    _claude_err "usage: ai <what you want to do>"
    return 1
  fi
  local out; out="$(_claude_cmd_gen_spin "$*" "$_CLAUDE_CMD_SYS")"
  [[ -z ${out//[[:space:]]/} ]] && { _claude_err "$_CLAUDE_MSG_NONE"; return 1; }
  _claude_offer "$out"
}

# ---- fix: correct/improve the last (or given) command ----
fix() {
  local target
  # `builtin fc` so the user's `alias fc=fzf...` can't hijack history lookup.
  if (( $# )); then target="$*"; else target="$(builtin fc -ln -1)"; fi
  [[ -z ${target//[[:space:]]/} ]] && { _claude_err "nothing to fix"; return 1; }

  local ctx=""
  [[ ! -t 0 ]] && ctx="$(cat)"

  local req="Correct or improve this shell command. Output only the fixed command.
COMMAND: $target"
  [[ -n $ctx ]] && req+="
ERROR OR OUTPUT:
$ctx"

  local out; out="$(_claude_cmd_gen_spin "$req" "$_CLAUDE_CMD_SYS")"
  [[ -z ${out//[[:space:]]/} ]] && { _claude_err "$_CLAUDE_MSG_NONE"; return 1; }
  _claude_offer "$out"
}

# ----------------------------------------------------------------- wtf -------

# Remember the last real command and how it exited. Registered at the FRONT of
# precmd_functions so it sees the true $? before starship's hook runs, and it
# returns that status untouched so starship still renders the error indicator.
_claude_wtf_preexec() {
  case ${1%% *} in
    wtf|fix|ai) return ;;   # asking about a failure must not overwrite it
  esac
  _CLAUDE_PENDING_CMD=$1
}

_claude_wtf_precmd() {
  local st=$?
  if [[ -n $_CLAUDE_PENDING_CMD ]]; then
    _CLAUDE_LAST_CMD=$_CLAUDE_PENDING_CMD
    _CLAUDE_LAST_STATUS=$st
    _CLAUDE_PENDING_CMD=''
  fi
  return $st
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec _claude_wtf_preexec
precmd_functions=(_claude_wtf_precmd ${precmd_functions:#_claude_wtf_precmd})

# True if re-running the command could change something. Deliberately trigger
# happy: a missed diagnosis is cheap, a repeated side effect is not.
_claude_wtf_mutates() {
  local c=$1
  [[ $c == *'>'* || $c == *'sudo '* ]] && return 0
  [[ $c =~ '(^|[|&;][[:space:]]*)(rm|rmdir|mv|cp|dd|mkfs|shred|truncate|ln|chmod|chown|kill|killall|pkill|shutdown|reboot|tee|scp|rsync|systemctl|launchctl|make|mvn|gradle)([[:space:]]|$)' ]] && return 0
  [[ $c =~ 'git[[:space:]]+(push|reset|rebase|commit|merge|clean|checkout|restore|cherry-pick|revert|tag|stash|am|apply|pull)' ]] && return 0
  [[ $c =~ '(npm|yarn|pnpm|bun)[[:space:]]+(i|install|ci|add|remove|rm|uninstall|publish|link|run)' ]] && return 0
  [[ $c =~ '(brew|pip|pip3|gem|cargo|go|asdf)[[:space:]]+(install|uninstall|remove|publish|add|build|get)' ]] && return 0
  [[ $c =~ '(docker|podman)[[:space:]]+(run|rm|rmi|push|build|compose|exec)' ]] && return 0
  [[ $c =~ 'kubectl[[:space:]]+(apply|delete|create|patch|scale|edit|rollout|exec)' ]] && return 0
  [[ $c =~ 'terraform[[:space:]]+(apply|destroy|import|init)' ]] && return 0
  [[ $c =~ '(apt|apt-get|yum|dnf|pacman|defaults[[:space:]]+write|stow)' ]] && return 0
  return 1
}

# The command may change something, so the user decides. Anything but an explicit
# yes means no, and no tty at all means no.
_claude_wtf_confirm() {
  [[ -t 0 && -t 2 ]] || return 1
  printf '  %s?%s %sre-run it to capture the real error? it may change things%s\n' \
    "$_CLAUDE_YEL" "$_CLAUDE_OFF" "$_CLAUDE_DIM" "$_CLAUDE_OFF" >&2
  local reply
  printf '    [y/N] ' >&2
  read -k 1 reply
  printf '\n' >&2
  [[ $reply == [yY] ]]
}

_claude_wtf_usage() {
  cat >&2 <<EOF

  ${_CLAUDE_BOLD}wtf${_CLAUDE_OFF} — explain why the last command failed

  ${_CLAUDE_BOLD}Usage${_CLAUDE_OFF}
    wtf              diagnose the last command
    wtf -n           never re-run it, reason from the command text alone
    wtf -r           re-run it even though it looks like it changes something
    <cmd> 2>&1 | wtf diagnose output you pipe in, no re-run at all

  To read the real error, wtf re-runs the last command with its output captured.
  Commands that look like they change something (rm, git push, npm install, ...)
  are never re-run — pipe their output in instead, or pass -r if you are sure.

EOF
}

wtf() {
  emulate -L zsh
  local rerun=auto piped=''

  while [[ $1 == -* ]]; do
    case $1 in
      -n|--no-run) rerun=never ;;
      -r|--run)    rerun=always ;;
      -h|--help)   _claude_wtf_usage; return 0 ;;
      *)           _claude_err "unknown option: $1"; _claude_wtf_usage; return 1 ;;
    esac
    shift
  done

  # tail, not head: build logs bury the real error at the bottom
  [[ ! -t 0 ]] && piped="$(cat | tail -c 4000)"

  local cmd=${_CLAUDE_LAST_CMD:-$(builtin fc -ln -1)}
  local st=${_CLAUDE_LAST_STATUS:-0}
  if [[ -z ${cmd//[[:space:]]/} ]]; then
    _claude_err "no previous command to diagnose"
    return 1
  fi

  printf '\n'
  _claude_field "cmd" "$_CLAUDE_BOLD" "$cmd"
  if (( st )); then
    _claude_field "exit" "$_CLAUDE_RED" "$st"
  else
    _claude_field "exit" "$_CLAUDE_DIM" "$st (it succeeded — diagnosing anyway)"
  fi

  local out="$piped" source_note='' blind=0
  if [[ -n $out ]]; then
    source_note='from piped output'
  elif [[ $rerun == never ]]; then
    source_note='not captured (-n)'; blind=1
  elif [[ $rerun != always ]] && _claude_wtf_mutates "$cmd" && ! _claude_wtf_confirm "$cmd"; then
    source_note='not captured — re-run declined'; blind=1
  else
    local tmp; tmp=$(mktemp)
    printf '  %s↻%s %sre-running to capture output…%s\n' \
      "$_CLAUDE_YEL" "$_CLAUDE_OFF" "$_CLAUDE_DIM" "$_CLAUDE_OFF" >&2
    ( eval "$cmd" ) >| "$tmp" 2>&1
    out="$(tail -c 4000 "$tmp")"; rm -f "$tmp"
    source_note='captured by re-running'
  fi
  _claude_note "output: ${source_note}"

  local out_block
  if (( blind )); then
    out_block='OUTPUT: (unavailable)'
  else
    out_block="OUTPUT (${source_note}):
${out:-(the command printed nothing)}"
  fi

  local req="Diagnose this failed shell command.
COMMAND: $cmd
EXIT STATUS: $st
DIRECTORY: $PWD
$out_block"

  local resp; resp="$(_claude_cmd_gen_spin "$req" "$_CLAUDE_WTF_SYS" 'diagnosing')"
  if [[ -z ${resp//[[:space:]]/} ]]; then
    _claude_err "$_CLAUDE_MSG_NONE"
    return 1
  fi

  local why sug
  why=$(print -r -- "$resp" | awk '/^WHY:/{f=1; sub(/^WHY:[[:space:]]*/,""); print; next} /^CMD:/{f=0} f')
  sug=$(print -r -- "$resp" | sed -n 's/^CMD:[[:space:]]*//p' | head -1)

  # A model that ignored the format still said something useful; show it raw.
  [[ -z ${why//[[:space:]]/} && -z ${sug//[[:space:]]/} ]] && why=$resp

  # never dress up a guess as a diagnosis
  local label=why lcolor=$_CLAUDE_CYA
  (( blind )) && { label=guess; lcolor=$_CLAUDE_YEL }

  printf '\n'
  [[ -n ${why//[[:space:]]/} ]] && _claude_field "$label" "$lcolor" "$why"

  if (( blind )); then
    _claude_note "it never saw the error — for a real answer: !! 2>&1 | wtf"
  fi

  if [[ -n ${sug//[[:space:]]/} && $sug != NONE ]]; then
    _claude_field "fix" "$_CLAUDE_GRN" "$sug"
    printf '\n'
    _claude_offer "$sug"
  else
    _claude_field "fix" "$_CLAUDE_DIM" "no single command fixes this one"
    printf '\n'
  fi
}
