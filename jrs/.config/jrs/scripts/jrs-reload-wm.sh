#!/bin/bash

if [ "$XDG_CURRENT_DESKTOP" = "i3" ] || [ "$XDG_CURRENT_DESKTOP" = "bspwm" ] || [ "$XDG_CURRENT_DESKTOP" = "Hyprland" ]; then
	hyprctl reload &
	killall -SIGUSR2 waybar &
	killall polybar &
	bash ~/.config/hypr/hyprpaper.sh &
	pkill -USR1 -x sxhkd &
	bspc wm -r &
	dunstctl reload &
	i3-msg restart &
	i3-msg reload &
fi
