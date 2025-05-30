#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Minimize window
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author asaday
# @raycast.authorURL https://raycast.com/asaday

tell application "System Events" to set miniaturized of front window of (first application process whose frontmost is true) to true
