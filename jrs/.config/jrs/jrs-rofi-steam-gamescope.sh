#!/bin/bash

# Steam OS FPS MENU Ctrl+Shift+Tab

steam-gamescope-1() {
	options="  Steam Gamescope (Start)\n  Steam Gamescope (Shutdown)"

	menu_cmd="rofi -dmenu -i -p Apps"

	# Show menu and get user selection
	chosen=$(echo -e "$options" | $menu_cmd)

	# Execute chosen action
	case "$chosen" in
	"  Steam Gamescope (Start)") gamescope -w 1600 -h 900 -W 1600 -H 900 -S stretch -f -C 5000 -e --cursor Adwaita --force-grab-cursor --mangoapp -- steam -steamdeck -steamos3 ;;
	"  Steam Gamescope (Shutdown)") steam -shutdown ;;
	*) exit 1 ;;
	esac
}

steam-gamescope-2() {
	if pgrep -x "steam" >/dev/null; then
		# Se o Steam estiver aberto, envia o comando para desligar
		dunstify -t 2000 --hints int:transient:1 "Steam Gamescope" "Closing" --icon=steam
		steam -shutdown
		exit 1
	else
		# Se estiver fechado, inicia o Steam com o Gamescope
		dunstify -t 2000 --hints int:transient:1 "Steam Gamescope" "Starting" --icon=steam
		gamescope -w 1600 -h 900 -W 1600 -H 900 -S stretch -f -C 5000 -e --cursor Adwaita --force-grab-cursor --mangoapp -- steam -steamdeck -steamos3
	fi
}

steam-gamescope-2