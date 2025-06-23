# Default commands
alias mv='mv -i'
alias rm='rm -rfi'
alias cp='cp -i'
alias lt='ls --human-readable --size -1 -S --classify'
alias ls='ls -F --color=auto'

# Git
alias dot='git -C $HOME/dotfiles'
alias g="git"
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
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
alias fc="fzf | xclip -selection clipboard"
alias fo="fzf | xargs -I{} xdg-open {}"
alias fv="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}' | xargs -I{} nvim {}"
alias fman="man -k . | fzf | xargs man"
alias ftldr="tldr --list | tr -s ' ' '\n' | tr ',' ' ' | fzf --preview 'tldr {1}' --height=60% --layout=reverse | xargs tldr"
alias fcht="curl cheat.sh/:list | fzf --preview 'curl cheat.sh/{1}' --height=60% --layout=reverse | xargs -I{} curl cheat.sh/{}"

# Other
alias v='vim'
alias lv='nvim'
alias nv='nvim'
alias py="python3"
alias del="trash-put"
alias r="ranger"
alias gc="gcc -Wall -Wextra -Werror -std=c99 -pedantic"
alias python="python3"
alias pip="pip3"
alias grep="grep --color=auto"
alias clip="xclip -selection clipboard"
alias vsc="code --profile clean"
alias code="code --profile Default"
alias gendir="mkdir -p {a,b}/{e,f,g}/{h,i,j}"
alias lzd="lazydocker"
alias p="pnpm"
alias x="git add . && git commit -m 'x' && git push"
alias gitlogin='eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_rsa'
alias c='code -r'
alias k='kubectl'

# Enable aliases to be sudo'ed
alias su='sudo '

# Valgrind and redirect output to a file
alias vg='valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=valgrind-out.txt'

# Search through command history
alias hs='history | grep'

# Upload file to 1pt.one
alias 1='ncc() { cat "$1" | curl -s -X POST --data-binary @- https://1pt.one | tee /dev/tty | xclip -selection clipboard; }; ncc'
