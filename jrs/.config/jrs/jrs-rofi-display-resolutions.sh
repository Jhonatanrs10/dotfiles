#!/bin/bash

source $HOME/.config/jrs/jrs-scripts-display-resolutions.sh

if [ "$XDG_CURRENT_DESKTOP" = "i3" ]; then
	options="eDP-1 Default ResX\neDP-1 Low ResX"
else
	options="eDP-1 Default ResW\neDP-1 Low ResW"
fi

menu_cmd="rofi -dmenu -i -p Resolutions"

# Show menu and get user selection
chosen=$(echo -e "$options" | $menu_cmd)

# Execute chosen action
case "$chosen" in
"eDP-1 Low ResW") nwg_displays_low_resolution ;;
"eDP-1 Default ResW") nwg_displays_default_resolution ;;
"eDP-1 Low ResX") xrandr_low_resolution ;;
"eDP-1 Default ResX") xrandr_default_resolution ;;
*) exit 1 ;;
esac
