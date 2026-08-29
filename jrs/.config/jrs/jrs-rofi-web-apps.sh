#!/bin/bash

source $HOME/.config/jrs/jrs-scripts-chromium-web-apps.sh

options=" Youtube\n Crunchyroll"

menu_cmd="rofi -dmenu -i -p Options"

# Show menu and get user selection
chosen=$(echo -e "$options" | $menu_cmd)

# Execute chosen action
case "$chosen" in
" Youtube") launch_chromium_web_app_youtube;;
" Crunchyroll") launch_chromium_web_app_crunchyroll ;;
*) exit 1 ;;
esac
