#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle AeroSpace Pause
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ⏸️
# @raycast.packageName AeroSpace

# Documentation:
# @raycast.description Toggles AeroSpace window management on/off, same as
# alt-shift-p in aerospace.toml. Exists as a Raycast command because AeroSpace's
# own hotkey listener stops responding once it's disabled, so alt-shift-p can
# pause it but can't un-pause it -- this runs outside AeroSpace's own tap, so it
# works in both directions regardless of current state.

/opt/homebrew/bin/aerospace enable toggle
$HOME/.config/aerospace/toggle-pause-state.sh

# if [ -f "$HOME/.aerospace_paused" ]; then
#   echo "AeroSpace paused"
# else
#   echo "AeroSpace resumed"
# fi
