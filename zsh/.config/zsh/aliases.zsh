# Default commands
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias gendir="mkdir -p {a,b}/{e,f,g}/{h,i,j}"
alias lt='ls --human-readable --size -1 -S --classify'
alias ls='ls -F --color=auto'
alias ..="cd .."
alias 2..='cd ../..'
alias 3..='cd ../../..'
alias 4..='cd ../../../..'
alias 5..='cd ../../../../..'

# Git
alias dot='git -C $HOME/dotfiles'
alias dotfiles='~/dotfiles/dotfiles'
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
alias fp="fzf --preview 'batcat --style=numbers --color=always --line-range :500 {}'"
alias fc="fzf | xclip -selection clipboard"
alias fv="fzf --preview 'batcat --style=numbers --color=always --line-range :500 {}' | xargs -I{} lvim {}"

# Other
alias v='vim'
alias lv='lvim'
alias py="python3"
alias bat="batcat"
alias del="trash-put"
alias fd="fdfind"
alias ye="yeelight-cli 192.168.1.20"
alias y="yarn"
alias r="ranger"
alias emptytrash="rm -pr -f ~/.local/share/Trash/files/*"
alias gc="gcc -Wall -Wextra -Werror -std=c99 -pedantic"
alias python="python3"
alias pip="pip3"
alias yee-toggle="yeelight-cli 192.168.1.20 toggle &"
alias yee-home="yeelight-cli 192.168.1.20 preset CosyHome"
alias yee-night="yeelight-cli 192.168.1.20 preset Night"
alias lofi-start="mpv --volume=60 --title=\"radio-mpv\" https://play.streamafrica.net/lofiradio &"
alias lofi-stop="pkill -f radio-mpv || main"
alias remap="xset r rate 300 50 ; xcape -e 'Super_L=Escape' "
alias pause="xdotool key XF86AudioPlay"
alias prev="xdotool key XF86AudioPrev"
alias next="xdotool key XF86AudioNext"
alias grep="grep --color=auto"
alias clip="xclip -selection clipboard"

# Enable aliases to be sudo'ed
alias su='sudo '

# Valgrind and redirect output to a file
alias vg='valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=valgrind-out.txt'

# Search through command history
alias hs='history | grep'
