# Starship prompt
eval "$(starship init bash)"

# FZF 
source /usr/share/doc/fzf/examples/key-bindings.bash
source /usr/share/doc/fzf/examples/completion.bash

export FZF_COMPLETION_TRIGGER=''

_fzf_compgen_path() {
  fdfind --type f --hidden --follow --exclude ".git"
}
_fzf_compgen_dir() {
  fdfind --type f --hidden --follow --exclude ".git"
}

# Functions and aliases
source $HOME/.config/zsh/functions.zsh
source $HOME/.config/zsh/aliases.zsh