#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Resize and Center (1500x800)
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🪟
# @raycast.packageName Window Management

# Documentation:
# @raycast.description Resizes the frontmost window to 1500x800 and centers it on the screen.
# @raycast.author asaday
# @raycast.authorURL https://raycast.com/asaday

osascript <<'EOF'
-- Get the dimensions of the primary display
tell application "Finder"
    set screenBounds to bounds of window of desktop
    set screenWidth to item 3 of screenBounds
    set screenHeight to item 4 of screenBounds
end tell

-- Define your target dimensions
set targetWidth to 1500
set targetHeight to 800

-- Calculate the centered X and Y coordinates
set posX to (screenWidth - targetWidth) / 2
set posY to (screenHeight - targetHeight) / 2

-- Apply the new size and position to the frontmost window
tell application "System Events"
    set frontApp to first application process whose frontmost is true
    set frontAppName to name of frontApp
    
    try
        tell frontApp
            set theWindow to front window
            -- Set size first, then position for better reliability
            set size of theWindow to {targetWidth, targetHeight}
            set position of theWindow to {posX, posY}
        end tell
    on error
        return "Failed to resize " & frontAppName & ". It might not have a resizable window."
    end try
end tell
EOF