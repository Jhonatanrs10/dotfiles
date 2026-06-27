#!/bin/bash

clear

dir_for_server_file="$HOME/Servers/PZServer"
mkdir -p $dir_for_server_file
cd $dir_for_server_file

run_server() {
	bash start-server.sh
}

update_server() {
	echo "Verifique se o diretorio do servidor é: $dir_for_server_file
[1]Update/Install"
	read -r choice2
	case "$choice2" in
	1) steamcmd +force_install_dir "$dir_for_server_file" +login anonymous +app_update 380870 validate +quit ;;
	*) echo "Saindo..." ;;
	esac

}

backup_server() {
	echo "coming"
}

install_steamcmd() {
	echo 'Instalar Steamcmd'
	yay -Syu steamcmd
}

echo "
PWD: $PWD

OPÇÕES
[1] ABRIR SERVER
[2] INSTALAR/ATUALIZAR SERVER
[3] BACKUP SAVE
[4] DEPENDENCIAS COM YAY (steamcmd)"

read -r choice
case "$choice" in
1) run_server ;;
2) update_server ;;
3) backup_server ;;
4) install_steamcmd ;;
*) echo "Saindo..." ;;
esac

#Update the information for future verification.
#Backup Date: 08/06/2026
#Game Version: v0.6.0.75365
#IP: localhost:8211
#Configure the server directory in the file: "run.sh"
#Obs: o server pode acabar gerando um novo save, basta mover os arquivos do diretorio do save antigo para o diretorio novo
