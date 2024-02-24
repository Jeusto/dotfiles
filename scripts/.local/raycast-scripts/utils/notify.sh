#!/bin/bash

# Check if the correct number of arguments is given
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <Title> <Message>"
    exit 1
fi

# Assign arguments to variables for better readability
TITLE="$1"
MESSAGE="$2"

# Use AppleScript to display the notification
osascript -e "display notification \"$MESSAGE\" with title \"$TITLE\""
