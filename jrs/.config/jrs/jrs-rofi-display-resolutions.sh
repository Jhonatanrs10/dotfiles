#!/bin/bash

nwg_displays_480p() {
	echo "monitor=eDP-1,854x480@60.02,0x0,1.0" >$HOME/.config/hypr/monitors.conf
	source $HOME/.config/jrs/jrs-reload-wm.sh
}

nwg_displays_768p() {
	echo "monitor=eDP-1,1366x768@60.02,0x0,1.0" >$HOME/.config/hypr/monitors.conf
	source $HOME/.config/jrs/jrs-reload-wm.sh
}

xrandr_480p(){
	xrandr --output DVI-D-0 --off --output HDMI-0 --primary --mode 1280x1024 --pos 0x0 --rotate normal --output DP-0 --mode 1600x900 --pos 1280x0 --rotate normal --output DP-1 --off
}

if [ "$XDG_CURRENT_DESKTOP" = "i3" ] || [ "$XDG_CURRENT_DESKTOP" = "bspwm" ]; then
	options="EMBREVE"
else
	options="eDP-1 480p\neDP-1 768p"
fi

menu_cmd="rofi -dmenu -i -p Resolutions"

# Show menu and get user selection
chosen=$(echo -e "$options" | $menu_cmd)

# Execute chosen action
case "$chosen" in
"eDP-1 480p") nwg_displays_480p ;;
"eDP-1 768p") nwg_displays_768p ;;
*) exit 1 ;;
esac
