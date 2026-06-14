#!/bin/bash

options="󱣵  Resolution WM\n  Kill Heroic & Gamescope"

menu_cmd="rofi -dmenu -i -p Options"

# Show menu and get user selection
chosen=$(echo -e "$options" | $menu_cmd)

# Execute chosen action
case "$chosen" in
"󱣵  Resolution WM") bash $HOME/.config/jrs/jrs-rofi-display-resolutions.sh ;;
"  Kill Heroic & Gamescope") pkill -9 gamescope && pkill -9 -f "heroic" && wineserver -k;;
*) exit 1 ;;
esac
