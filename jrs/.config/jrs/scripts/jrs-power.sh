#!/bin/bash

options="⏻ Shutdown\n Restart\n⏾ Suspend\n󰒲 Hibernate\n󰗽 Logout"

# Detect session type and choose appropriate menu
if [ "$XDG_SESSION_TYPE" = "x11" ] && command -v rofi &>/dev/null; then
  menu_cmd="rofi -dmenu -i -p Options"
elif [ "$XDG_SESSION_TYPE" = "wayland" ] && command -v wofi &>/dev/null; then
  #menu_cmd="wofi --dmenu --prompt=Options"
  menu_cmd="rofi -dmenu -i -p Options"
else
  echo "ERROR: No suitable menu found" >&2
  exit 1
fi

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
