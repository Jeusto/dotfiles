export THEME=dark

# Path
export PATH=\
/home/linuxbrew/.linuxbrew/bin/:\
/usr/share/code/:\
$HOME/local/share/flatpak/exports/bin:\
/var/lib/flatpak/exports/bin:\
$HOME/.cargo/bin:\
$HOME/.local:\
$HOME/.local/bin:\
$HOME/.bin:\
$PNPM_HOME:\
$PATH

# Environment variables
export BROWSER=firefox
export EDITOR=lvim
export VISUAL=lvim
export GOPATH=/home/asaday/.go
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export HISTCONTROL=ignoreboth
export QT_QPA_PLATFORMTHEME=gtk2
export FZF_DEFAULT_COMMAND="fdfind --type f --hidden --follow --exclude .git"
export FZF_COMPLETION_TRIGGER=''
export TERM="xterm-256color"
export PNPM_HOME="/home/asaday/.local/share/pnpm"

# Change FZF and Bat color scheme depending on system theme
if [[ $THEME == "dark" ]]
then
  export BAT_THEME="OneHalfDark"
  export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
   --color=dark
   --color=fg:#abb2bf,hl:#326996
   --color=fg+:#d3dae6,bg+:#3b414d,hl+:#61afef
   --color=info:#e5c07b,prompt:#e06c75,pointer:#c678dd
   --color=marker:#98c379,spinner:#c678dd,header:#56b6c2'
else
  export BAT_THEME="OneHalfLight"
  export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
   --color=light
   --color=fg:#696c77,hl:#4078f2
   --color=fg+:#202227,bg+:#f0f0f1,hl+:#4078f2
   --color=info:#c18401,prompt:#202227,pointer:#0184bc
   --color=marker:#0184bc,spinner:#0184bc,header:#4078f2'
fi
