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
  zsh-autosuggestions command-not-found zsh-z)

# Other
. "$HOME/.cargo/env"
source $HOME/.oh-my-zsh/oh-my-zsh.sh
PROMPT_EOL_MARK=''
setopt globdots

# Vi mode cursor
# bindkey -v

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
bindkey '\ef' fzf-file-widget
bindkey '^F' fzf-file-widget
bindkey '\eh' fzf-history-widget
bindkey '^H' fzf-history-widget
bindkey '\ec' fzf-cd-widget

# Z Plugin
zstyle ':completion:*' menu select

# Autosuggest plugin
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#4e5666"
