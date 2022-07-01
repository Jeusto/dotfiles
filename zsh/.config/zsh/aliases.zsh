# Default commands
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias gendir="mkdir -p {a,b}/{e,f,g}/{h,i,j}"
alias lt='ls --human-readable --size -1 -S --classify'
alias ..="cd .."
alias 2..='cd ../..'
alias 3..='cd ../../..'
alias 4..='cd ../../../..'
alias 5..='cd ../../../../..'

# Git
alias dot='git -C $HOME/Dotfiles'
alias g="git"
alias gs="git status"
alias gf="git fetch"

# Exa
alias l="exa --icons"
alias la="exa -a --icons"
alias ll="exa -l --icons"
alias l1="l -1"
alias l1a="l -1 -a"
alias lla="ll -a"

# FZF
alias fzfp="fzf --preview 'batcat --style=numbers --color=always --line-range :500 {}'"
alias fzfc="fzf | xclip -selection clipboard"
alias fzfv="fzf | xargs -I{} nvim {}"

# Other
alias v='nvim'
alias py="python3"
alias bat="batcat"
alias del="trash-put"
alias fd="fdfind"
alias pp="xdotool key XF86AudioPlay"
alias prev="xdotool key XF86AudioPrev"
alias next="xdotool key XF86AudioNext"
alias ye="yeelight-cli 192.168.1.20"
alias y="yarn"
alias r="ranger"
alias emptytrash="rm -pr -f ~/.local/share/Trash/files/*"

[[ "$TERM" == "xterm-kitty" ]] && alias ssh="kitty +kitten ssh"

# Enable aliases to be sudo'ed
alias su='sudo '

# Print each PATH entry on a separate line
alias path="echo -e ${PATH//:/\\n}"

# Valgrind and redirect output to a file
alias vg='valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=valgrind-out.txt'

# Search through command history
alias hs='history | grep'