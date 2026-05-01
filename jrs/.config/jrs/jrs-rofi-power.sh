#!/bin/bash

exit-wm() {
	if [ "$XDG_CURRENT_DESKTOP" = "i3" ]; then
		i3-msg exit
	elif [ "$XDG_CURRENT_DESKTOP" = "Hyprland" ]; then
		hyprctl dispatch exit
	else
		dunstify -t 2000 --hints int:transient:1 "i3wm or Hyprland" "Not founded." --icon=xfce4-cpugraph-plugin
	fi
}

options="⏻ Shutdown\n Restart\n⏾ Suspend\n󰒲 Hibernate\n󰗽 Logout\n󰅚 Exit WM"

menu_cmd="rofi -dmenu -i -p Options"

# Show menu and get user selection
chosen=$(echo -e "$options" | $menu_cmd)

# Execute chosen action
case "$chosen" in
"⏻ Shutdown") systemctl poweroff ;;
" Restart") systemctl reboot ;;
"⏾ Suspend") systemctl suspend ;;
"󰒲 Hibernate") systemctl hibernate ;;
"󰗽 Logout") pkill -KILL -u $USER ;;
"󰅚 Exit WM") exit-wm ;;
*) exit 1 ;;
esac
