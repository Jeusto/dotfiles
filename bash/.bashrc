# Starship prompt
eval "$(starship init bash)"

# FZF 
source /usr/share/doc/fzf/examples/key-bindings.bash
source /usr/share/doc/fzf/examples/completion.bash

# _fzf_compgen_path() {
#   fd --hidden --follow --exclude ".git" . "$1"
# }
# _fzf_compgen_path() {
#   fdfind 
# }
_fzf_compgen_dir() {
  fdfind --max-depth 1
}
# _fzf_comprun() {
#   local command=$1
#   shift

#   case "$command" in
#     cd)           fzf "$@" --max-depth 1 --preview 'tree -C {} | head -200' ;;
#     *)            fzf "$@" ;;
#   esac
# }

# Plugins
source $HOME/.bash-plugins/z.sh
source $HOME/.bash-plugins/fzf-tab.sh

# Functions and aliases
source $HOME/.config/zsh/functions.zsh
source $HOME/.config/zsh/aliases.zsh