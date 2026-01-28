#!/bin/bash

options="  Discord (Flatpak)\n  Discord (Pacman)"

menu_cmd="rofi -dmenu -i -p Apps"

# Show menu and get user selection
chosen=$(echo -e "$options" | $menu_cmd)

# Execute chosen action
case "$chosen" in
"  Discord (Flatpak)") env ELECTRON_OZONE_PLATFORM_HINT= com.discordapp.Discord --no-sandbox;;
"  Discord (Pacman)") env ELECTRON_OZONE_PLATFORM_HINT= discord --no-sandbox;;
  *) exit 1 ;;
esac
