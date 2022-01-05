# This script is called on startup to remap keys

# Increase key speed via a rate change
xset r rate 300 50

# Map the caps lock key to super
# gsettings set org.gnome.desktop.input-sources xkb-options "['caps:super']"

# But when it's pressed only once, treat it as escape
xcape -e '#66=Escape'

# Disable map overview on super key and map it to Super+W
