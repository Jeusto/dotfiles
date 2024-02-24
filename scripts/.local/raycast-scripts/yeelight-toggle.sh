#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Yeelight
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 💡
# @raycast.packageName Yeelight

# Documentation:
# @raycast.author Arhun Saday
# @raycast.authorURL https://raycast.com/asaday

yeelight_ip="192.168.1.20"

# Function to send the command to the Yeelight device
fn_send() {
    ip=$yeelight_ip
    # Redirecting echo to /dev/null to suppress output
    echo "Executing on ID $1 [$ip] ... " $@ >/dev/null
    if ping -c1 -W1 $ip >/dev/null; then
        # Directly writing to the device without printing to stdout
        printf "{\"id\":1,$2}\r\n" >/dev/tcp/$ip/55443
    else
        # Redirecting error message to stderr or suppress it
        echo "$ip not available" >&2
    fi
}

# Command template
ct='"method":"toggle","params":[,,]'
fn_send "$ct"
