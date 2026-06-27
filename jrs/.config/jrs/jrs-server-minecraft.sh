#!/bin/bash

clear

dir_for_server_file="$HOME/Servers/MineServer"
mkdir -p $dir_for_server_file
cd $dir_for_server_file

run_server() {
	java -Xmx4G -Xms4G -jar server.jar nogui
}

update_server() {
	link_for_server_file="https://piston-data.mojang.com/v1/objects/823e2250d24b3ddac457a60c92a6a941943fcd6a/server.jar"
	echo "Verifique se o diretorio do servidor é: $dir_for_server_file
[1]Update/Install 
[2]Gerar server.properties"
	read -r choice2
	case "$choice2" in
	1)
		wget -c "$link_for_server_file" -O "server.jar"
		echo "eula=true" >>eula.txt
		;;
	2)
		echo "online-mode=false
motd=A Minecraft Server  \u00A77By Jhonatanrs
server-port=25565
enable-command-block=true" >>"server.properties"
		;;
	*) echo "Saindo..." ;;
	esac

}

backup_server() {
	echo "coming"
}

echo "
PWD: $PWD

OPÇÕES
[1] ABRIR SERVER
[2] INSTALAR/ATUALIZAR SERVER
[3] BACKUP SAVE"

read -r choice
case "$choice" in
1) run_server ;;
2) update_server ;;
3) backup_server ;;
*) echo "Saindo..." ;;
esac
