#!/bin/bash

tui_chromium_web_apps() {
	source $HOME/.config/jrs/jrs-scripts-chromium-web-apps.sh
	clear
	echo "[1] Youtube
[2] Crunchyroll"

	read chosen

	case "$chosen" in
	1) launch_chromium_web_app_youtube ;;
	2) launch_chromium_web_app_crunchyroll ;;
	*) exit 1 ;;
	esac
}
