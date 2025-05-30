#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <file-to-send>"
    exit 1
fi

# Define variables
FILE_TO_SEND="$1"
KINDLE_USER="root"
KINDLE_IP="192.168.1.193"
KINDLE_PORT="2222"
KINDLE_PATH="/mnt/us/koreader/books"

# Send the file using scp
scp -P $KINDLE_PORT "$FILE_TO_SEND" "$KINDLE_USER@$KINDLE_IP:$KINDLE_PATH"

# Check if the scp command was successful
if [ $? -eq 0 ]; then
    echo "File successfully sent to Kindle."
else
    echo "Failed to send the file to Kindle."
    exit 1
fi
