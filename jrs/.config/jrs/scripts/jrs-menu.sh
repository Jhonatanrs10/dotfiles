#!/bin/bash
#teste
jrs-menu-1() {
	options="Reload Window Manager\nRestart Hyprpaper"
	menu_cmd="rofi -dmenu -i -p Debugs"
	chosen=$(echo -e "$options" | $menu_cmd)
	case "$chosen" in
	"Reload Window Manager") bash ~/.config/jrs/scripts/jrs-reload-wm.sh ;;
	"Restart Hyprpaper") bash ~/.config/jrs/scripts/jrs-restart-hyprpaper.sh ;;
	*) exit 1 ;;
	esac
}
options="Dotfiles Update\nThemes\nPower Profiles\nDebug"
menu_cmd="rofi -dmenu -i -p Scripts"
chosen=$(echo -e "$options" | $menu_cmd)
case "$chosen" in
"Dotfiles Update") alacritty -e ~/.config/jrs/scripts/jrs-mydotfiles.sh ;;
"Themes") bash ~/.config/jrs/scripts/jrs-themes.sh ;;
"Power Profiles") bash ~/.config/jrs/scripts/jrs-power-profiles.sh ;;
"Debug") jrs-menu-1 ;;
*) exit 1 ;;
esac
