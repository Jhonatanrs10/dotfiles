#!/bin/bash

nwg_displays_low_resolution() {
	echo "monitor=eDP-1,854x480@60.02,0x0,1.0" >$HOME/.config/hypr/monitors.conf
	source $HOME/.config/jrs/jrs-reload-wm.sh
}

nwg_displays_default_resolution() {
	echo "monitor=eDP-1,1366x768@60.02,0x0,1.0" >$HOME/.config/hypr/monitors.conf
	source $HOME/.config/jrs/jrs-reload-wm.sh
}

xrandr_low_resolution(){
	xrandr --output eDP-1 --mode 864x486 --pos 1280x0 --rotate normal
}

xrandr_default_resolution(){
	xrandr --output eDP-1 --mode 1366x768 --pos 1280x0 --rotate normal
}

if [ "$XDG_CURRENT_DESKTOP" = "i3" ] || [ "$XDG_CURRENT_DESKTOP" = "bspwm" ]; then
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
