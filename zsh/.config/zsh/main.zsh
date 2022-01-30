###############################
###  General configuration  ###
###############################

# Enable Powerlevel10k instant prompt. Should stay close to the top
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
ZLE_RPROMPT_INDENT=0

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(git fzf fzf-tab zsh-syntax-highlighting 
  zsh-autosuggestions vi-mode command-not-found)

# Other
source $HOME/.oh-my-zsh/oh-my-zsh.sh
PROMPT_EOL_MARK=''
setopt globdots

# Vi mode cursor
bindkey -v

# Remove mode switching delay.
KEYTIMEOUT=5

# Change cursor shape for different vi modes.
function zle-keymap-select {
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

# Use beam shape cursor for each new prompt.
preexec() {
    echo -ne '\e[5 q'
}

###############
###  Other  ###
###############

# Disable sort when completing 'git checkout'
zstyle ':completion:*:git-checkout:*' sort false
# Set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# Set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# Preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# Switch group using ',' and '.'
zstyle ':fzf-tab:*' switch-group ',' '.'

# Powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
autoload -U compinit && compinit -u

# FZF 
source /usr/share/doc/fzf/examples/key-bindings.zsh
