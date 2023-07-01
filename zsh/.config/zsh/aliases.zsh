# Default commands
alias mv='mv -i'
alias rm='rm -rfi'
alias cp='cp -i'
alias lt='ls --human-readable --size -1 -S --classify'
alias ls='ls -F --color=auto'

# Git
alias dot='git -C $HOME/dotfiles'
alias dotfiles='~/dotfiles/dotfiles'
alias g="git"
alias gs="git status"
alias gf="git fetch"
alias gg="lazygit"
alias lg="lazygit"

# Exa
alias l="exa --icons"
alias la="exa -a --icons"
alias ll="exa -l --icons"
alias l1="l -1"
alias l1a="l -1 -a"
alias lla="ll -a"

# FZF
alias fp="fzf --preview 'batcat --style=numbers --color=always --line-range :500 {}'"
alias fc="fzf | xclip -selection clipboard"
alias fo="fzf | xargs -I{} xdg-open {}"
alias fv="fzf --preview 'batcat --style=numbers --color=always --line-range :500 {}' | xargs -I{} lvim {}"
alias fman="man -k . | fzf"
alias ftldr="tldr --list | tr -s ' ' '\n' | tr ',' ' ' | fzf --preview 'tldr {1}' --height=60% --layout=reverse | xargs tldr"
alias fcht="curl cheat.sh/:list | fzf --preview 'curl cheat.sh/{1}' --height=60% --layout=reverse | xargs -I{} curl cheat.sh/{}"

# Enable aliases to be sudo'ed
alias su='sudo '

# Valgrind and redirect output to a file
alias vg='valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=valgrind-out.txt'

# Search through command history
alias hs='history | grep'

# Other
alias v='vim'
alias lv='lvim'
alias tlv='export TRANSPARENT_NVIM=1 && lvim'
alias py="python3"
alias bat="batcat"
alias del="trash-put"
alias fd="fdfind"
alias ye="yeelight-cli 192.168.1.20"
alias r="ranger"
alias emptytrash="rm -pr -f ~/.local/share/Trash/files/*"
alias gc="gcc -Wall -Wextra -Werror -std=c99 -pedantic"
alias python="python3"
alias pip="pip3"
alias grep="grep --color=auto"
alias clip="xclip -selection clipboard"
alias vsc="code --profile clean"
alias code="code --profile Default"
alias cht="cht.sh"
alias gendir="mkdir -p {a,b}/{e,f,g}/{h,i,j}"
alias lzd="lazydocker"
alias updateall="sudo apt update && sudo apt upgrade && flatpak update"
alias p="pnpm"
alias xdg="xdg-open"
alias dotfiles="git -C $HOME/dotfiles"
