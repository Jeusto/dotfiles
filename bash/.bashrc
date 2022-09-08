# Starship prompt
eval "$(starship init bash)"

# FZF 
source $HOME/.bash-plugins/fzf-key-bindings.bash
source $HOME/.bash-plugins/fzf-completion.bash

_fzf_compgen_dir() {
  fdfind --max-depth 1
}

# Plugins
source $HOME/.bash-plugins/z.sh
source $HOME/.bash-plugins/fzf-tab.sh

# Functions and aliases
source $HOME/.config/zsh/functions.zsh
source $HOME/.config/zsh/aliases.zsh
