#!/bin/bash

touch ~/.config/rofi/colors.rasi &&
	options="  Dotfiles\n󱄋  Reload WM\n  Themes\n  Power Profiles\n  Debug\n󰐦  Quit"

menu_cmd="rofi -dmenu -i -p Go"

# Show menu and get user selection
chosen=$(echo -e "$options" | $menu_cmd)

# Execute chosen action
case "$chosen" in
"  Dotfiles") bash $HOME/.config/jrs/jrs-rofi-git-dotfiles.sh ;;
"󱄋  Reload WM") bash $HOME/.config/jrs/jrs-exec-reload-wm.sh ;;
"  Themes") bash $HOME/.config/jrs/jrs-rofi-set-theme.sh ;;
"  Power Profiles") bash $HOME/.config/jrs/jrs-rofi-power-profiles.sh ;;
"  Debug") bash $HOME/.config/jrs/jrs-rofi-debug.sh ;;
"󰐦  Quit") bash $HOME/.config/jrs/jrs-rofi-power.sh ;;
*) exit 1 ;;
esac
