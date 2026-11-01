#!/bin/bash

exit-wm() {
	if [ "$XDG_CURRENT_DESKTOP" = "i3" ]; then
		i3-msg exit
	elif [ "$XDG_CURRENT_DESKTOP" = "bspwm" ]; then
		bspc quit
	elif [ "$XDG_CURRENT_DESKTOP" = "Hyprland" ]; then
		command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'
	else
		dunstify -t 2000 --hints int:transient:1 "i3wm or Hyprland" "Not founded." --icon=xfce4-cpugraph-plugin
	fi
}

shutdown-wm() {
	if [ "$XDG_CURRENT_DESKTOP" = "i3" ]; then
		systemctl poweroff
	elif [ "$XDG_CURRENT_DESKTOP" = "bspwm" ]; then
		systemctl poweroff
	elif [ "$XDG_CURRENT_DESKTOP" = "Hyprland" ]; then
		command -v hyprshutdown --post-cmd "systemctl poweroff" >/dev/null 2>&1 && hyprshutdown --post-cmd "systemctl poweroff" || hyprctl dispatch 'hl.dsp.exit()'
	else
		dunstify -t 2000 --hints int:transient:1 "i3wm or Hyprland" "Not founded." --icon=xfce4-cpugraph-plugin
	fi
}

restart-wm() {
	if [ "$XDG_CURRENT_DESKTOP" = "i3" ]; then
		systemctl reboot
	elif [ "$XDG_CURRENT_DESKTOP" = "bspwm" ]; then
		systemctl reboot
	elif [ "$XDG_CURRENT_DESKTOP" = "Hyprland" ]; then
		command -v hyprshutdown --post-cmd "systemctl reboot" >/dev/null 2>&1 && hyprshutdown --post-cmd "systemctl reboot" || hyprctl dispatch 'hl.dsp.exit()'
	else
		dunstify -t 2000 --hints int:transient:1 "i3wm or Hyprland" "Not founded." --icon=xfce4-cpugraph-plugin
	fi
}

tui_power() {

	clear
	echo "[1] Shutdown
[2] Restart
[3] Suspend
[4] Hibernate
[5] Logout
[6] Exit WM"

	read chosen

	case "$chosen" in
	1) shutdown-wm ;;
	2) restart-wm ;;
	3) systemctl suspend ;;
	4) systemctl hibernate ;;
	5) pkill -KILL -u $USER ;;
	6) exit-wm ;;
	esac
}