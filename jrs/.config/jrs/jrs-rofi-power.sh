#!/bin/bash

source $HOME/.config/jrs/jrs-scripts-power.sh

options="⏻ Shutdown\n Restart\n⏾ Suspend\n󰒲 Hibernate\n󰗽 Logout\n󰅚 Exit WM"

menu_cmd="rofi -dmenu -i -p Options"

# Show menu and get user selection
chosen=$(echo -e "$options" | $menu_cmd)

# Execute chosen action
case "$chosen" in
"⏻ Shutdown") shutdown-wm ;;
" Restart") restart-wm ;;
"⏾ Suspend") systemctl suspend ;;
"󰒲 Hibernate") systemctl hibernate ;;
"󰗽 Logout") pkill -KILL -u $USER ;;
"󰅚 Exit WM") exit-wm ;;
*) exit 1 ;;
esac
