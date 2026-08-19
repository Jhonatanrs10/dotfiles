#!/bin/bash
source $HOME/.config/jrs/jrs-scripts-reload-wm.sh
case "$XDG_CURRENT_DESKTOP" in
"i3") reload_i3 ;;
"Hyprland") reload_Hyprland ;;
*) ;;
esac
