#!/bin/bash

reload_Hyprland() {
	hyprctl reload &
	killall -SIGUSR2 waybar &
	bash ~/.config/hypr/hyprpaper.sh &
	dunstctl reload &
	dunstify -t 1500 --hints int:transient:1 "$XDG_CURRENT_DESKTOP" "Reloading" --icon=preferences-desktop-theme
}

reload_bspwm() {
	killall polybar &
	pkill -USR1 -x sxhkd &
	bspc wm -r &
	dunstctl reload &
	dunstify -t 1500 --hints int:transient:1 "$XDG_CURRENT_DESKTOP" "Reloading" --icon=preferences-desktop-theme
}

reload_i3() {
	killall polybar &
	i3-msg restart &
	i3-msg reload &
	dunstctl reload &
	dunstify -t 1500 --hints int:transient:1 "$XDG_CURRENT_DESKTOP" "Reloading" --icon=preferences-desktop-theme
}

case "$XDG_CURRENT_DESKTOP" in
"i3") reload_i3 ;;
"bspwm") reload_bspwm ;;
"Hyprland") reload_Hyprland ;;
*) ;;
esac
