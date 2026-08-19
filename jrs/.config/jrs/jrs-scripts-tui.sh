#!/bin/bash

main_tui() {
	touch ~/.config/rofi/colors.rasi &&
		chosen="null"
	while [ "$chosen" != "0" ]; do
		clear
		echo "[0] Exit TUI

[1] Dotfiles
[2] Reload WM
[3] Themes
[4] Power Profiles
[5] Debug
[6] Quit"
		read chosen
		case "$chosen" in
		1) bash -c 'source "$HOME/.config/jrs/jrs-scripts-tui-git-dotfiles.sh"; tui_git_dotfiles';;
		2) bash -c 'source "$HOME/.config/jrs/jrs-exec-reload-wm.sh"; ';;
		3) bash -c 'source "$HOME/.config/jrs/jrs-scripts-tui-set-theme.sh"; tui_set_theme';;
		4) bash -c 'source "$HOME/.config/jrs/jrs-scripts-tui-power-profiles.sh"; tui_power_profiles';;
		5) bash -c 'source "$HOME/.config/jrs/jrs-scripts-tui-debug.sh"; tui_debug';;
		6) bash -c 'source "$HOME/.config/jrs/jrs-scripts-tui-power.sh"; tui_power';;
		0) chosen="0";;
		esac
	done

}
