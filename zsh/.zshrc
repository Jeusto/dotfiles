source $HOME/.config/zsh/main.zsh
source $HOME/.config/zsh/functions.zsh
source $HOME/.config/zsh/aliases.zsh

# Asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# fnm
FNM_PATH="/Users/asaday/Library/Application Support/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/Users/asaday/Library/Application Support/fnm:$PATH"
  eval "`fnm env`"
fi