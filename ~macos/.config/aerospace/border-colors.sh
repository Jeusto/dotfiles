#!/bin/sh
# Shared border color presets for JankyBorders, called from toggle-pause-state.sh
# and fullscreen-border.sh so both stay consistent. Re-invoking `borders` with
# new args updates the already-running instance live (no restart needed).
BORDERS="/opt/homebrew/bin/borders"

# Same app list as the on-window-detected floating rules in aerospace.toml:
# these apps are always floating, so they never get a tiling-style border either.
BLACKLIST="App Store,Messages,System Settings,Calculator,Raycast,Karabiner-Elements,Bartender 5,Finder,Activity Monitor,Spotify,Electron,Stickies,Preview,CLIP STUDIO PAINT,League of Legends,Unity Hub,Archive Utility"

borders_normal() {
  "$BORDERS" active_color=0xffabb2bf inactive_color=0xff494d64 width=6.0 blacklist="$BLACKLIST"
}

borders_paused() {
  "$BORDERS" active_color=0xffe5c07b inactive_color=0xff494d64 width=6.0 blacklist="$BLACKLIST"
}

borders_fullscreen() {
  "$BORDERS" active_color=0xff61afef inactive_color=0xff494d64 width=6.0 blacklist="$BLACKLIST"
}

# Allow running this file directly (e.g. from after-startup-command) to apply
# the normal/startup style, while still being sourced by the other scripts
# without triggering this.
if [ "$(basename "$0")" = "border-colors.sh" ]; then
  borders_normal
fi
