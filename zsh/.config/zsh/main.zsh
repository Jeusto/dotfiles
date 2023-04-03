###############################
###  General configuration  ###
###############################

# Starship prompt
eval "$(starship init zsh)"

# List hidden files by default
setopt globdots

# Save commands history to a file
HISTFILE=~/.zsh_history
HISTSIZE=25000
SAVEHIST=25000
setopt incappendhistory
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY

#################
###  Plugins  ###
#################

# Clone zcomet if necessary
if [[ ! -f ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh ]]; then
  git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR:-${HOME}}/.zcomet/bin
fi
# Source zcomet.zsh
source ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh

# Plugins
zcomet load agkozak/zsh-z
zcomet load Aloxaf/fzf-tab
zcomet load ohmyzsh plugins/command-not-found
zcomet load zsh-users/zsh-syntax-highlighting
zcomet load zsh-users/zsh-autosuggestions
zcomet load kutsan/zsh-system-clipboard
zcomet snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh

# FZF keybindings
zle -N fzf-redraw-prompt
zle     -N   fzf-file-widget
bindkey '^T' fzf-file-widget
zle     -N    fzf-cd-widget
bindkey '\ec' fzf-cd-widget
zle     -N   fzf-history-widget
bindkey '^R' fzf-history-widget

# Z Plugin
zstyle ':completion:*' menu select

# Autosuggest
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#777777"
bindkey '^E' autosuggest-accept

# Run compinit and compile its cache
zcomet compinit

###############
###  Other  ###
###############

# Case insensitive autocompletion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit

# Set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'

# Set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'

# Preview file content with bat when completing cat
zstyle ':fzf-tab:complete:lvim:*' fzf-preview 'batcat -p --color=always $realpath'

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
  zle -K viins
}

zle -N zle-line-init

# Show insert/command mode in vi.
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

# Tmux
bindkey -s ^F "tmux-sessionizer\n"
bindkey -s ^H "tmux-cht\n"