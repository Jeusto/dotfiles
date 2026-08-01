#!/bin/sh
# Called right after `aerospace fullscreen` toggles, to reflect the resulting
# state in JankyBorders' color. Re-evaluates paused state too (paused takes
# priority) so this can't clobber a paused border with a stale fullscreen color.
. "$HOME/.config/aerospace/border-colors.sh"

if [ -f "$HOME/.aerospace_paused" ]; then
  borders_paused
elif [ "$(/opt/homebrew/bin/aerospace list-windows --focused --format "%{window-is-fullscreen}" 2>/dev/null)" = "true" ]; then
  borders_fullscreen
else
  borders_normal
fi
