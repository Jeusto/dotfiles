#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Set Yeelight Brightness Level
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 💡
# @raycast.packageName Yeelight
# @raycast.argument1 { "type": "text", "placeholder": "level" }

# Documentation:
# @raycast.author Arhun Saday
# @raycast.authorURL https://raycast.com/asaday
ct='"method":"set_bright","params":['$1', "smooth", 500]'
$(dirname $0)/utils/yeelight.sh "$ct"
