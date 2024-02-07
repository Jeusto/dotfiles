# Default apps
export BROWSER=firefox
export EDITOR=lvim
export VISUAL=lvim

# Fzf config
export FZF_DEFAULT_COMMAND="fdfind --type f --follow --exclude node_modules"
export FZF_COMPLETION_TRIGGER=''

# Colors
export BAT_THEME="ansi"
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color fg:-1,bg:-1,hl:65,fg+:33,bg+:-1,hl+:108
--color info:108,prompt:109,spinner:108,pointer:168,marker:168'

# Colorful man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Other
export PNPM_HOME="/home/asaday/.local/share/pnpm"
export GOPATH="$HOME/.go"
export GOROOT="/usr/local/go"

# Path
export PATH=\
$HOME/.cargo/bin:\
$HOME/.deno/bin:\
$HOME/.local:\
$HOME/.local/bin:\
$HOME/.local/scripts:\
$PNPM_HOME:\
$GOPATH/bin:\
$GOROOT/bin:\
$PATH
