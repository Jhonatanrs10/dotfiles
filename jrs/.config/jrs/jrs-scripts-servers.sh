#!/bin/bash

dedicated_servers() {
	echo "Servers
[1] Palworld
[2] Project Zomboid
[3] Valheim
[4] Minecraft
"
	read -r choice
	case "$choice" in
	1) bash -c 'source "$HOME/.config/jrs/jrs-scripts-server-palworld.sh"; setup_server' ;;
	2) bash -c 'source "$HOME/.config/jrs/jrs-scripts-server-project-zomboid.sh"; setup_server' ;;
	3) bash -c 'source "$HOME/.config/jrs/jrs-scripts-server-valheim.sh"; setup_server' ;;
	4) bash -c 'source "$HOME/.config/jrs/jrs-scripts-server-minecraft.sh"; setup_server' ;;
	*) echo "Saindo..." ;;
	esac
}

# exec nesse caso faz com que o bash a seguir substitua o processo do bash atual