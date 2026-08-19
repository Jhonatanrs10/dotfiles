#!/bin/bash

source $HOME/.config/jrs/jrs-scripts-power-profiles.sh

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

