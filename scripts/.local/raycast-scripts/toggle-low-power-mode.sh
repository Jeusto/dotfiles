#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle low power mode
# @raycast.mode silent
# @raycast.

# Optional parameters:
# @raycast.icon 🔋
# @raycast.packageName System

# Documentation:
# @raycast.author asaday
# @raycast.authorURL https://raycast.com/asaday

password=$(security find-generic-password -w -s 'Sudo password' -a 'sudo')
 
# Check if low power mode is enabled
# pmset -g |grep lowpowermode
lowpower_enabled=$(pmset -g | grep lowpowermode | awk '{print $2}')

if [ $lowpower_enabled -eq 1 ]; then
  echo $password | sudo -S pmset -a lowpowermode 0 2>/dev/null
  lowpower_status="off"
else
  echo $password | sudo -S pmset -a lowpowermode 1 2>/dev/null
  lowpower_status="on"
fi

echo "Low power mode is now $lowpower_status"

