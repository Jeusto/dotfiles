#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open new iTerm window
# @raycast.mode silent
# @raycast.packageName iTerm
#
# Optional parameters:
# @raycast.icon images/iterm-logo.png

tell application "iTerm"
    create window with default profile
end tell
return
