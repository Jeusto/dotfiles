# ==============================================================================
#  General configuration  
# ==============================================================================

# Starship prompt
eval "$(starship init zsh)"

# Commands history
HISTCONTROL=ignoreboth
HISTFILE=~/.zsh_history
HISTSIZE=1000000000
SAVEHIST=1000000000
setopt incappendhistory
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY

# ==============================================================================
# Plugins
# ==============================================================================

# Clone zcomet if necessary
if [[ ! -f ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh ]]; then
  git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR:-${HOME}}/.zcomet/bin
fi
# Source zcomet.zsh
source ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh

# Plugins
zcomet load agkozak/zsh-z
zcomet load Aloxaf/fzf-tab
zcomet load zsh-users/zsh-syntax-highlighting
zcomet load zsh-users/zsh-autosuggestions
zcomet load kutsan/zsh-system-clipboard

# Snippets
zcomet snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh

# FZF keybindings
zle -N fzf-redraw-prompt
zle -N fzf-file-widget
zle -N fzf-cd-widget
zle -N fzf-history-widget
bindkey '^T' fzf-file-widget
bindkey '\ec' fzf-cd-widget
bindkey '^R' fzf-history-widget

# Z 
zstyle ':completion:*' menu select

# Autosuggest
bindkey '^E' autosuggest-accept

# ==============================================================================
# Other
# ==============================================================================

# Case insensitive autocompletion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# Run compinit and compile its cache
zcomet compinit

# Set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'

# Preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -A --color=always $realpath'

# Preview file content with bat when completing cat
zstyle ':fzf-tab:complete:nvim:*' fzf-preview 'batcat -p --color=always $realpath'

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

# Show vi mode indicator in prompt
function zle-line-init() {
  zle -K viins
}
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
zle -N zle-line-init
zle -N zle-keymap-select

# Tmux
# bindkey -s ^F "tmux-sessionizer\n"
# bindkey -s ^H "tmux-cht\n"

# ZVM_VI_INSERT_ESCAPE_BINDKEY=jk