#!/bin/bash

main_tui() {
	touch ~/.config/rofi/colors.rasi &&
		chosen="null"
	while [ "$chosen" != "0" ]; do
		clear
		echo "[0] Exit TUI

[1] Dotfiles
[2] Web Apps
[3] Reload WM
[4] Themes
[5] Power Profiles
[6] Debug
[7] Quit"
		read chosen
		case "$chosen" in
		1) bash -c 'source "$HOME/.config/jrs/jrs-scripts-tui-git-dotfiles.sh"; tui_git_dotfiles';;
		2) bash -c 'source "$HOME/.config/jrs/jrs-scripts-tui-chromium-web-apps.sh"; tui_chromium_web_apps';;
		3) bash -c 'source "$HOME/.config/jrs/jrs-exec-reload-wm.sh"; ';;
		4) bash -c 'source "$HOME/.config/jrs/jrs-scripts-tui-set-theme.sh"; tui_set_theme';;
		5) bash -c 'source "$HOME/.config/jrs/jrs-scripts-tui-power-profiles.sh"; tui_power_profiles';;
		6) bash -c 'source "$HOME/.config/jrs/jrs-scripts-tui-debug.sh"; tui_debug';;
		7) bash -c 'source "$HOME/.config/jrs/jrs-scripts-tui-power.sh"; tui_power';;
		0) chosen="0";;
		esac
	done

}
