#!/bin/bash

nwg_displays_low_resolution() {
	echo "monitor=eDP-1,854x480@60.02,0x0,1.0" >$HOME/.config/hypr/monitors.conf
	source $HOME/.config/jrs/jrs-reload-wm.sh
	reload_wm
}

nwg_displays_default_resolution() {
	echo "monitor=eDP-1,1366x768@60.02,0x0,1.0" >$HOME/.config/hypr/monitors.conf
	source $HOME/.config/jrs/jrs-reload-wm.sh
	reload_wm
}

xrandr_low_resolution(){
	xrandr --output eDP-1 --mode 864x486 --pos 1280x0 --rotate normal
}

xrandr_default_resolution(){
	xrandr --output eDP-1 --mode 1366x768 --pos 1280x0 --rotate normal
}