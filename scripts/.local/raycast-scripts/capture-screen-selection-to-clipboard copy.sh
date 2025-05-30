#!/bin/sh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Capture Screen Selection to Clipboard
# @raycast.mode silent
# @raycast.packageName System
#
# Optional parameters:
# @raycast.icon 💻

screencapture -ci

FILENAME=~/Pictures/Screenshots/screenshot-$(date +%Y%m%d-%H%M%S).png

sleep 0.5

osascript <<EOF > /dev/null 2>&1
set filePath to POSIX file "$FILENAME" as text
tell application "System Events"
    set pngData to the clipboard as «class PNGf»
    try
        set fileRef to open for access filePath with write permission
        write pngData to fileRef starting at 0
        close access fileRef
    on error errMsg
        display dialog "Error writing file: " & errMsg
        try
            close access fileRef
        end try
    end try
end tell
EOF