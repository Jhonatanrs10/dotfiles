#!/bin/bash

options="  Steam Gamescope (Start)\n  Steam Gamescope (Shutdown)"

menu_cmd="rofi -dmenu -i -p Apps"

# Show menu and get user selection
chosen=$(echo -e "$options" | $menu_cmd)

# Execute chosen action
case "$chosen" in
"  Steam Gamescope (Start)") gamescope -w 1600 -h 900 -W 1600 -H 900 -S stretch -f -C 5000 -e --cursor Adwaita --force-grab-cursor --mangoapp -- steam -steamdeck -steamos3 ;;
"  Steam Gamescope (Shutdown)") steam -shutdown;;
*) exit 1 ;;
esac
