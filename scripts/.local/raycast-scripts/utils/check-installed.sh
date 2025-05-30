#!/bin/bash

# Check if the tool is installed
if ! command -v "$1" &>/dev/null; then
    echo "$1 is not installed."
    exit 1
else
    echo "$1 is installed."
fi
