#############################
### General configuration ###
#############################

# Enable Powerlevel10k instant prompt. Should stay close to the top
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
ZLE_RPROMPT_INDENT=0

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Remind me to update when it's time
zstyle ':omz:update' mode reminder  

# Plugins
plugins=(git fzf-tab vi-mode zsh-syntax-highlighting zsh-autosuggestions command-not-found)

# Other
source $HOME/.oh-my-zsh/oh-my-zsh.sh
PROMPT_EOL_MARK=''
setopt globdots

# Enable vim mode
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

  # Use beam shape cursor on startup.
  echo -ne '\e[5 q'

  # Use beam shape cursor for each new prompt.
  preexec() {
      echo -ne '\e[5 q'
  }

###############
###  Other  ###
###############

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[[ -s /home/asaday/.autojump/etc/profile.d/autojump.sh ]] && source /home/asaday/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u

# Disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false

# Set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'

# Set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'

# Switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# Fzf theme colors
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
 --color=fg:#abb2bf,bg:#282c34,hl:#326996
 --color=fg+:#d3dae6,bg+:#3b414d,hl+:#61afef
 --color=info:#e5c07b,prompt:#e06c75,pointer:#c678dd
 --color=marker:#98c379,spinner:#c678dd,header:#56b6c2'
