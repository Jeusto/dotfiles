#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Stage Manager and Yabai
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🎭
# @raycast.packageName System

# Documentation:
# @raycast.author asaday
# @raycast.authorURL https://raycast.com/asaday
#
stageManagerEnabled=$(defaults read com.apple.WindowManager GloballyEnabled)

if [ "$stageManagerEnabled" = 1 ]; then
  defaults write com.apple.WindowManager GloballyEnabled -bool false
  echo "Stage Manager disabled. Starting Yabai..."
  yabai --start-service
else
  defaults write com.apple.WindowManager GloballyEnabled -bool true
  echo "Stage Manager enabled. Stopping Yabai..."
  yabai --stop-service
fi

