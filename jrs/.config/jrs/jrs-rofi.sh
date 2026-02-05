#!/bin/bash

options="  Search\n󱓟  Launchers\n  Themes\n  Power Profiles\n  Debug\n󰐦  Quit"

menu_cmd="rofi -dmenu -i -p Options"

# Show menu and get user selection
chosen=$(echo -e "$options" | $menu_cmd)

# Execute chosen action
case "$chosen" in
"  Search") rofi -show drun ;;
"󱓟  Launchers") bash $HOME/.config/jrs/jrs-rofi-apps.sh ;;
"  Themes") bash $HOME/.config/jrs/jrs-rofi-themes.sh ;;
"  Power Profiles") bash $HOME/.config/jrs/jrs-rofi-power-profiles.sh ;;
"  Debug") bash $HOME/.config/jrs/jrs-rofi-debug.sh ;;
"󰐦  Quit") bash $HOME/.config/jrs/jrs-rofi-power.sh ;;
"code") code ~/.dotfiles ;;
*) exit 1 ;;
esac
