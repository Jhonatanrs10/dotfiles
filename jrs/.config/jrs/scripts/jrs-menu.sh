#!/bin/bash

jrs-menu-1() {
	options="Reload Window Manager\nRestart Hyprpaper\nDotfiles Update"
	menu_cmd="rofi -dmenu -i -p Debugs"
	chosen=$(echo -e "$options" | $menu_cmd)
	case "$chosen" in
	"Reload Window Manager") bash ~/.config/jrs/scripts/jrs-reload-wm.sh ;;
	"Restart Hyprpaper") bash ~/.config/jrs/scripts/jrs-restart-hyprpaper.sh ;;
	"Dotfiles Update") alacritty -e ~/.config/jrs/scripts/jrs-mydotfiles.sh ;;
	*) exit 1 ;;
	esac
}
options="Power Options\nThemes\nPower Profiles\nDebug"
menu_cmd="rofi -dmenu -i -p Scripts"
chosen=$(echo -e "$options" | $menu_cmd)
case "$chosen" in
"Themes") bash ~/.config/jrs/scripts/jrs-themes.sh ;;
"Power Profiles") bash ~/.config/jrs/scripts/jrs-power-profiles.sh ;;
"Power Options") bash ~/.config/jrs/scripts/jrs-power.sh ;;
"Debug") jrs-menu-1 ;;
*) exit 1 ;;
esac
