#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Auto Hide and Show Dock
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🚀
# @raycast.packageName System

# Documentation:
# @raycast.author yourname
# @raycast.authorURL https://raycast.com/yourname
#
dockAutoHide=$(defaults read com.apple.dock autohide)

if [[ $dockAutoHide -eq 0 ]]; then
  defaults write com.apple.dock autohide -bool true
  echo "Enabled Auto Hide and Show Dock"
else
  defaults write com.apple.dock autohide -bool false
  echo "Disabled Auto Hide and Show Dock"
fi

killall Dock
