#!/bin/bash

picom-stop(){
  killall picom
  dunstify -t 2000 --hints int:transient:1 "Picom" "Stopped" --icon=picom
}

picom-start(){
  picom &
  dunstify -t 2000 --hints int:transient:1 "Picom" "Started" --icon=picom
}

profile-performance(){
  powerprofilesctl set performance
  dunstify -t 2000 --hints int:transient:1 "Power Profile" "Performance" --icon=xfce4-cpugraph-plugin
}

profile-balanced(){
  powerprofilesctl set balanced
  dunstify -t 2000 --hints int:transient:1 "Power Profile" "Balanced" --icon=xfce4-cpugraph-plugin
}

profile-power-saver(){
  powerprofilesctl set power-saver
  dunstify -t 2000 --hints int:transient:1 "Power Profile" "Power Saver" --icon=xfce4-cpugraph-plugin
}

if [ "$XDG_CURRENT_DESKTOP" = "i3" ] || [ "$XDG_CURRENT_DESKTOP" = "bspwm" ];then
  if pgrep picom > /dev/null; then
    options="Performance\nBalanced\nPower Saver\nPicom Stop"
  else
    options="Performance\nBalanced\nPower Saver\nPicom Start"
  fi
else
  options="Performance\nBalanced\nPower Saver"
fi

# Detect session type and choose appropriate menu
if [ "$XDG_SESSION_TYPE" = "x11" ] && command -v rofi &>/dev/null; then
  menu_cmd="rofi -dmenu -i -p Profiles"
elif [ "$XDG_SESSION_TYPE" = "wayland" ] && command -v wofi &>/dev/null; then
  #menu_cmd="wofi --dmenu --prompt=Options"
  menu_cmd="rofi -dmenu -i -p Profiles"
else
  echo "ERROR: No suitable menu found" >&2
  exit 1
fi

# Show menu and get user selection
chosen=$(echo -e "$options" | $menu_cmd)

# Execute chosen action
case "$chosen" in
  "Performance")profile-performance;;
  "Balanced")profile-balanced;;
  "Power Saver")profile-power-saver;;
  "Picom Start")picom-start;;
  "Picom Stop")picom-stop;;
  *) exit 1 ;;
esac