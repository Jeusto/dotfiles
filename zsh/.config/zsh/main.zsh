###############################
###  General configuration  ###
###############################

setopt globdots

# Starship prompt
eval "$(starship init zsh)"

# Save commands history to a file
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt incappendhistory

#################
###  Plugins  ###
#################

source $HOME/.config/zsh/plugins/command-not-found.plugin.zsh
source $HOME/.config/zsh/plugins/colored-man-pages.plugin.zsh
source $HOME/.config/zsh/plugins/zsh-autosuggestions.zsh
source $HOME/.config/zsh/plugins/zsh-z.plugin.zsh
source $HOME/.config/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
source $HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# FZF keybindings
source $HOME/.config/zsh/plugins/fzf-key-bindings.zsh

# Z Plugin
zstyle ':completion:*' menu select

# Autosuggest 
if [[ $THEME = "light" ]]; then
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#7a8599"
else
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#4e5666"
fi

bindkey '^E' autosuggest-accept

###############
###  Other  ###
###############

# Case insensitive autocompletion
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

# Vi with some Emacs flavor control keys.
bindkey -v
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^L" clear-screen
bindkey "^U" kill-whole-line
bindkey "^W" backward-kill-word
bindkey "^Y" yank
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

function zle-line-init() {
  # Note: this initial mode must match the $VIMODE initial value above.
  zle -K viins
}

zle -N zle-line-init

# Show insert/command mode in vi.
# zle-keymap-select is executed every time KEYMAP changes.
function zle-keymap-select {
  VIMODE="${${KEYMAP/vicmd/ C}/(main|viins)/ I}"
  zle reset-prompt
  zle -R

  if [[ ${KEYMAP} == vicmd ]] ||
      [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
        [[ ${KEYMAP} == viins ]] ||
        [[ ${KEYMAP} = '' ]] ||
        [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
