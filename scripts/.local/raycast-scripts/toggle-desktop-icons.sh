#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Desktop Icons Visibility
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 💻

# Documentation:
# @raycast.author asaday
# @raycast.authorURL https://raycast.com/asaday

currentVisibility=$(defaults read com.apple.finder CreateDesktop)

if [ $currentVisibility -eq 1 ]; then
  defaults write com.apple.finder CreateDesktop -bool false
else
  defaults write com.apple.finder CreateDesktop -bool true
fi

killall Finder

