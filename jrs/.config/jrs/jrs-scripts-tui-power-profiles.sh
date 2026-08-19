#!/bin/bash

tui_power_profiles() {
	source $HOME/.config/jrs/jrs-scripts-power-profiles.sh

	clear

	echo "[1] Performance
[2] Balanced
[3] Power Saver
[4] Picom Start
[5] Picom Stop"

	read chosen

	# Execute chosen action
	case "$chosen" in
	1) profile-performance ;;
	2) profile-balanced ;;
	3) profile-power-saver ;;
	4) picom-start ;;
	5) picom-stop ;;
	0) exit 1 ;;
	esac

}
