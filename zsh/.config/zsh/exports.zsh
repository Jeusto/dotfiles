# Environment variables
export BROWSER=firefox
export EDITOR=lvim
export VISUAL=lvim

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export FZF_DEFAULT_COMMAND="fdfind --type f --follow --exclude node_modules"
export HISTCONTROL=ignoreboth
export QT_QPA_PLATFORMTHEME=gtk2
export FZF_COMPLETION_TRIGGER=''
export HISTSIZE=1000000000
export SAVEHIST=1000000000

export PNPM_HOME="/home/asaday/.local/share/pnpm"
export GOPATH="$HOME/.go"
export GOROOT="/usr/local/go"
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export JAVA_HOME=/home/asaday/.local/share/flatpak/app/com.google.AndroidStudio/x86_64/stable/b5287410e271345870a5cba62dd4b9294b091295decbc478d81baff32262fe46/files/extra/android-studio/jbr
export CAPACITOR_ANDROID_STUDIO_PATH=/home/asaday/.local/share/flatpak/app/com.google.AndroidStudio/x86_64/stable/b5287410e271345870a5cba62dd4b9294b091295decbc478d81baff32262fe46/files/extra/android-studio/bin/studio.sh

# Colors
export BAT_THEME="ansi"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color fg:-1,bg:-1,hl:65,fg+:33,bg+:-1,hl+:108
--color info:108,prompt:109,spinner:108,pointer:168,marker:168'

# Colorful man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Path
export PATH=\
/home/linuxbrew/.linuxbrew/bin/:\
/home/linuxbrew/.linuxbrew/opt/node@18/bin/:\
/var/lib/flatpak/exports/bin:\
$HOME/.cargo/bin:\
$HOME/.deno/bin:\
$HOME/.local:\
$HOME/.local/bin:\
$HOME/.local/scripts:\
$HOME/.local/share/pop-launcher/scripts:\
$HOME/Android/Sdk/tools/bin:\
$HOME/Android/Sdk/cmdline-tools/latest/bin:\
$HOME/Android/Sdk/platform-tools:\
$HOME/Android/Sdk/emulator:\
$PNPM_HOME:\
$GOPATH/bin:\
$GOROOT/bin:\
$PATH
