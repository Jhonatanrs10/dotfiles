#!/bin/bash

picom-stop() {
  killall picom
  dunstify -t 2000 --hints int:transient:1 "Picom" "Stopped" --icon=picom
}

picom-start() {
  picom &
  dunstify -t 2000 --hints int:transient:1 "Picom" "Started" --icon=picom
}

profile-performance() {
  powerprofilesctl set performance
  dunstify -t 2000 --hints int:transient:1 "Power Profile" "Performance" --icon=xfce4-cpugraph-plugin
}

profile-balanced() {
  powerprofilesctl set balanced
  dunstify -t 2000 --hints int:transient:1 "Power Profile" "Balanced" --icon=xfce4-cpugraph-plugin
}

profile-power-saver() {
  powerprofilesctl set power-saver
  dunstify -t 2000 --hints int:transient:1 "Power Profile" "Power Saver" --icon=xfce4-cpugraph-plugin
}

if [ "$XDG_CURRENT_DESKTOP" = "i3" ]; then
  if pgrep picom >/dev/null; then
    options="  Performance\n  Balanced\n  Power Saver\n󰰙  Picom Stop"
  else
    options="  Performance\n  Balanced\n  Power Saver\n󰰙  Picom Start"
  fi
else
  options="  Performance\n  Balanced\n  Power Saver"
fi

menu_cmd="rofi -dmenu -i -p Profiles -width 40"

# Show menu and get user selection
chosen=$(echo -e "$options" | $menu_cmd)

# Execute chosen action
case "$chosen" in
"  Performance") profile-performance ;;
"  Balanced") profile-balanced ;;
"  Power Saver") profile-power-saver ;;
"󰰙  Picom Start") picom-start ;;
"󰰙  Picom Stop") picom-stop ;;
*) exit 1 ;;
esac

