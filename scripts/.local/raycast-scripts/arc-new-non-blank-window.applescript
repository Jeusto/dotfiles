#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title New non blank Arc window
# @raycast.mode silent
# @raycast.packageName Arc
# @raycast.icon images/arc.png

tell application "Arc"
  make new window 
  activate
end tell
