#################
###  Aliases  ###
#################

# Enable aliases to be sudo’ed
alias su='sudo '

# Empty trash
alias emptytrash="rm -rf ~/.local/share/Trash/*"

# Print each PATH entry on a separate line
alias path="echo -e ${PATH//:/\\n}"

# Valgrind output to file
alias vg='valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=valgrind-out.txt'

# Search through command history
alias hs='history | grep'

# Show files sorted by size
alias lt='ls --human-readable --size -1 -S --classify'

# Other
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias dot='git -C $HOME/Dotfiles'
alias g="git"
alias bat="batcat"
alias gs="git status"
alias gf="git fetch"
alias la='ls -A'
alias l='ls -CF'
alias ll='ls -alF'
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias vim='nvim'
alias v='nvim'
alias fzfp="fzf --preview 'batcat --style=numbers --color=always --line-range :500 {}'"
alias gendir="mkdir -p {a,b}/{e,f,g}/{h,i,j}"
alias del="trash-put"
