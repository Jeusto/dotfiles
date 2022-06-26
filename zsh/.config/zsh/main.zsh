###############################
###  General configuration  ###
###############################

# Starship prompt
eval "$(starship init zsh)"

# Plugins
source $HOME/.config/zsh/plugins/command-not-found.plugin.zsh
source $HOME/.config/zsh/plugins/colored-man-pages.plugin.zsh
source $HOME/.config/zsh/plugins/zsh-autosuggestions.zsh
source $HOME/.config/zsh/plugins/zsh-z.plugin.zsh
source $HOME/.config/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
source $HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Other
bindkey -e
PROMPT_EOL_MARK=''
setopt globdots

# Save commands history to a file
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

#################
###  Plugins  ###
#################

# FZF keybindings
source /usr/share/doc/fzf/examples/key-bindings.zsh
export FZF_COMPLETION_TRIGGER=''
bindkey '\ef' fzf-file-widget
bindkey '^F' fzf-file-widget

# Z Plugin
zstyle ':completion:*' menu select

# Autosuggest 
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#4e5666"

###############
###  Other  ###
###############

# Some keymaps
bindkey '^l' forward-word
bindkey '^h' backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Case insesitive autocompletion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit
# Disable sort when completing 'git checkout'
zstyle ':completion:*:git-checkout:*' sort false
# Set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# Set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# Preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'