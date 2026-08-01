#!/bin/sh
# Tracks whether AeroSpace window management is paused, since `aerospace enable`
# has no query command of its own. Only ever call this together with
# `aerospace enable toggle` (same keybind/Raycast command) so the two stay in sync.
STATE_FILE="$HOME/.aerospace_paused"
. "$HOME/.config/aerospace/border-colors.sh"

if [ -f "$STATE_FILE" ]; then
  rm "$STATE_FILE"
else
  touch "$STATE_FILE"
fi

# Re-evaluate full state (paused takes priority over fullscreen) rather than
# just applying "paused"/"normal", so this can't clobber a fullscreen border
# that fullscreen-border.sh set more recently.
if [ -f "$STATE_FILE" ]; then
  borders_paused
elif [ "$(/opt/homebrew/bin/aerospace list-windows --focused --format "%{window-is-fullscreen}" 2>/dev/null)" = "true" ]; then
  borders_fullscreen
else
  borders_normal
fi
