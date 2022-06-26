# To use with the gnome extension "Night theme switcher"

# Day time
sed -i '$ d' ~/.config/rofi/config.rasi ; echo "@theme \"spotlight.rasi\"" >> ~/.config/rofi/config.rasi ; ~/.local/bin/kitty +kitten themes --reload-in=all "Atom One Light" ; sed -i '1s/.*/export THEME=light/' ~/.config/zsh/exports.zsh

# Night time
sed -i '$ d' ~/.config/rofi/config.rasi ; echo "@theme \"spotlight-dark.rasi\"" >> ~/.config/rofi/config.rasi ; ~/.local/bin/kitty +kitten themes --reload-in=all "One Dark" ; sed -i '1s/.*/export THEME=dark/' ~/.config/zsh/exports.zsh