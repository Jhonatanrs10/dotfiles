#!/bin/bash

options="󱣵  WM Res\n  Kill Applets\n󰹯  Rofi Desktop\n  Kill Heroic & Gamescope"

menu_cmd="rofi -dmenu -i -p Options"

# Show menu and get user selection
chosen=$(echo -e "$options" | $menu_cmd)

# Execute chosen action
case "$chosen" in
"󱣵  WM Res") bash $HOME/.config/jrs/jrs-rofi-display-resolutions.sh ;;
"  Kill Applets") killall nm-applet blueman-applet;;
"󰹯  Rofi Desktop") bash $HOME/.config/jrs/jrs-rofi-desktop.sh ;;
"  Kill Heroic & Gamescope") pkill -9 gamescope && pkill -9 -f "heroic" && wineserver -k;;
*) exit 1 ;;
esac
