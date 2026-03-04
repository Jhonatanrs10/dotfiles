#!/bin/bash

options="  Discord Wayland\n  SteamOS"

menu_cmd='rofi -dmenu -i -placeholder "  Search..."'

# Show menu and get user selection
chosen=$(echo -e "$options" | $menu_cmd)

# Execute chosen action
case "$chosen" in
"  Discord Wayland") bash $HOME/.config/jrs/jrs-rofi-discord.sh ;;
"  SteamOS") bash $HOME/.config/jrs/jrs-rofi-steamos.sh ;;
*) exit 1 ;;
esac
