#!/bin/bash

dedicated_servers() {
	clear
	echo "[1] Palworld
[2] Project Zomboid
[3] Valheim
[4] Minecraft
"
	read -r choice
	case "$choice" in
	1) bash -c 'source "$HOME/.config/jrs/jrs-server-palworld.sh"; setup_server' ;;
	2) bash -c 'source "$HOME/.config/jrs/jrs-server-project-zomboid.sh"; setup_server' ;;
	3) bash -c 'source "$HOME/.config/jrs/jrs-server-valheim.sh"; setup_server' ;;
	4) bash -c 'source "$HOME/.config/jrs/jrs-server-minecraft.sh"; setup_server' ;;
	*) echo "Saindo..." ;;
	esac
}

# exec nesse caso faz com que o bash a seguir substitua o processo do bash atual