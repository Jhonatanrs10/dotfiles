#!/bin/bash

reload_Hyprland() {
  hyprctl reload &
  killall waybar
  sleep 0.2
  waybar &>/dev/null &
  bash ~/.config/hypr/hyprpaper.sh &
  dunstctl reload &
  pkill -USR2 btop &
  dunstify -t 1500 --hints int:transient:1 "$XDG_CURRENT_DESKTOP" "Reloading" --icon=preferences-desktop-theme
}

reload_i3() {
  killall polybar &
  i3-msg restart &
  i3-msg reload &
  dunstctl reload &
  pkill -USR2 btop &
  dunstify -t 1500 --hints int:transient:1 "$XDG_CURRENT_DESKTOP" "Reloading" --icon=preferences-desktop-theme
}

case "$XDG_CURRENT_DESKTOP" in
"i3") reload_i3 ;;
"Hyprland") reload_Hyprland ;;
*) ;;
esac