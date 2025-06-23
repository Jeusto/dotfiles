#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Send Selected File to Kindle
# @raycast.mode silent
# @raycast.packageName System
#
# Optional parameters:
# @raycast.icon ??
#
# Documentation:
# @raycast.description Send the currently selected file in Finder to Kindle using SSH.

on run
    log "Sending the selected file to Kindle..."

    tell application "Finder"
        -- get Finder selected items
        set theItems to selection
    end tell

    -- check if exactly one item is selected
    if (count of theItems) is not equal to 1 then
        display dialog "Please select exactly one file in Finder."
        return
    end if

    -- get the item path
    set theItem to POSIX path of (first item of theItems as string)

    -- call the shell script to send the file to Kindle
    do shell script "/path/to/send_to_kindle.sh " & quoted form of theItem

    -- notify the user
    display notification "File sent to Kindle successfully." with title "Send to Kindle"
end run
