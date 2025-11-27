#!/bin/bash

options="⏻ Shutdown\n Restart\n⏾ Suspend\n󰒲 Hibernate\n󰗽 Logout"

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
  *) exit 1 ;;
esac
