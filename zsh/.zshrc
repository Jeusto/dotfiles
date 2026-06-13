source $HOME/.config/zsh/main.zsh
source $HOME/.config/zsh/functions.zsh
source $HOME/.config/zsh/aliases.zsh

# Asdf
# . /opt/homebrew/opt/asdf/libexec/asdf.sh

# fnm
FNM_PATH="/Users/asaday/Library/Application Support/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/Users/asaday/Library/Application Support/fnm:$PATH"
  eval "`fnm env`"
fi
eval "$(fnm env --use-on-cd --shell zsh)"

# Scaleway CLI autocomplete initialization.
eval "$(scw autocomplete script shell=zsh)"

# Sdkman
export SDKMAN_DIR=$(brew --prefix sdkman-cli)/libexec
[[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
# Added by Antigravity
export PATH="/Users/asaday/.antigravity/antigravity/bin:$PATH"

export JAVA_HOME=/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home
