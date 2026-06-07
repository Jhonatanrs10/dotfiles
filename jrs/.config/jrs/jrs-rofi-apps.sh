#!/bin/bash

options="  Discord Wayland\n  Steam Gamescope\n󰰢  Syncthing\n  Live Setup"

menu_cmd='rofi -dmenu -i -placeholder "  Search..."'

# Show menu and get user selection
chosen=$(echo -e "$options" | $menu_cmd)

# Execute chosen action
case "$chosen" in
"  Discord Wayland") bash $HOME/.config/jrs/jrs-rofi-discord.sh ;;
"  Steam Gamescope") bash $HOME/.config/jrs/jrs-exec-steam-gamescope.sh ;;
"󰰢  Syncthing") xdg-open http://localhost:8384/ ;;
"  Live Setup") bash $HOME/.config/jrs/jrs-exec-live-setup.sh ;;
*) exit 1 ;;
esac
