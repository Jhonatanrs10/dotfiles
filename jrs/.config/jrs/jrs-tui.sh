#!/bin/bash

touch ~/.config/rofi/colors.rasi &&
	chosen="null"
while [ "$chosen" != "0" ]; do
	clear
	echo "[1] Dotfiles
[2] Reload WM
[3] Themes
[4] Power Profiles
[5] Debug
[6] Quit"
	read chosen
	case "$chosen" in
	1) bash $HOME/.config/jrs/jrs-exec-git-dotfiles.sh && exit;;
	2) bash $HOME/.config/jrs/jrs-exec-reload-wm.sh && exit;;
	3) bash $HOME/.config/jrs/jrs-tui-set-theme.sh && exit;;
	4) bash $HOME/.config/jrs/jrs-tui-power-profiles.sh && exit;;
	5) bash $HOME/.config/jrs/jrs-rofi-debug-tui.sh && exit;;
	6) bash $HOME/.config/jrs/jrs-tui-power.sh && exit;;
	0) exit 1 ;;
	esac
done
