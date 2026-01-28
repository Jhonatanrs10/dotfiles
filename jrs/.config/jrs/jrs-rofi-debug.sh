#!/bin/bash

options="󱣵  WM Res\n  kill applets\n󰹯  Rofi Desktop"

menu_cmd="rofi -dmenu -i -p Options"

# Show menu and get user selection
chosen=$(echo -e "$options" | $menu_cmd)

# Execute chosen action
case "$chosen" in
"󱣵  WM Res") bash $HOME/.config/jrs/jrs-rofi-display-resolutions.sh ;;
"  kill applets") bash $HOME/.config/jrs/jrs-killall-applets.sh ;;
"󰹯  Rofi Desktop") bash $HOME/.config/jrs/jrs-rofi-desktop.sh ;;
*) exit 1 ;;
esac
