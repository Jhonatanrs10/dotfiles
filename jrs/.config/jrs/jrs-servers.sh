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
	1) exec bash $HOME/.dotfiles/jrs/.config/jrs/jrs-server-palworld.sh ;;
	2) exec bash $HOME/.dotfiles/jrs/.config/jrs/jrs-server-project-zomboid.sh ;;
	3) exec bash $HOME/.dotfiles/jrs/.config/jrs/jrs-server-valheim.sh ;;
	4) exec bash $HOME/.dotfiles/jrs/.config/jrs/jrs-server-minecraft.sh ;;
	*) echo "Saindo..." ;;
	esac
}

# exec nesse caso faz com que o bash a seguir substitua o processo do bash atual