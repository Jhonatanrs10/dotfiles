#!/bin/bash

touch ~/.config/rofi/colors.rasi &&
	options="Sample"

menu_cmd="rofi -dmenu -i -p Go"

# Show menu and get user selection
chosen=$(echo -e "$options" | $menu_cmd)

# Execute chosen action
case "$chosen" in
"Sample") ;;
*) exit 1 ;;
esac
