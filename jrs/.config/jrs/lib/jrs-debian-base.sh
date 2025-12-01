#!/bin/bash
addArchi386() {
	echo -e '[INFO] - ADCIONANDO ARQUITETURA DE 32 BITS - [INFO]'
	sudo dpkg --add-architecture i386
}

aptUpdate() {
	echo -e "[INFO] - ATUALIZANDO REPOSITORIO E FAZENDO ATUALIZACAO DO SISTEMA - [INFO]"
	sudo apt update && sudo apt dist-upgrade -y
}

installDebs() {
	echo -e "[INFO] - INSTALANDO PACOTES DEB - [INFO]"
	sudo dpkg -i $1/*.deb
}

justAptUpdate() {
	echo -e "[INFO] - ATUALIZANDO O REPOSITORIO - [INFO]"
	sudo apt update -y
}

supFlatpakApt() {
	sudo add-apt-repository ppa:flatpak/stable
	sudo apt update
	sudo apt install flatpak
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

teste_internet() {
	echo -e "[INFO] - VERIFICANDO CONEXAO COM A REDE - [INFO]"
	if ! ping -c 1 8.8.8.8 -q >/dev/null 2>&1; then
		echo -e "[INFO] - SEM CONEXAO COM INTERNET - [INFO]"
		exit 1
	else
		echo -e "[INFO] - CONEXAO COM INTERNET FUNCIONANDO NORMALMENTE - [INFO]"
	fi
}

travas_apt() {
	sudo rm /var/lib/dpkg/lock-frontend
	sudo rm /var/cache/apt/archives/lock
}

installDriverNvidia() {
	aptUpdate
	ubuntu-drivers devices
	echo "Visualizar Drivers: ubuntu-drivers devices
Instalar Drivers: sudo apt install nvidia-driver-X"
}

posInstallDeb() {
	yesorno "Deseja testar conexao?" "teste_internet"
	travas_apt
	justAptUpdate
	addArchi386
	yesorno "Instalar o Flatpak?" "supFlatpak"
	echo "PACOTES:
samba gparted neofetch blueman mpv vlc git wget openjdk-8-jdk openjdk-11-jdk openjdk-17-jdk htop qbittorrent"
	read pacotes
	packagesManager "$pacotes"
	baixaDebs "Chrome" "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
	baixaDebs "vscode" "https://go.microsoft.com/fwlink/?LinkID=760868"
	baixaDebs "Discord" "https://discord.com/api/download?platform=linux&format=deb"
	baixaDebs "Steam" "https://cdn.akamai.steamstatic.com/client/installer/steam.deb"
	yesorno "Deseja instalar os .deb?" "installDebs $diretorioBaixaDebs"
	yesorno "Deseja apagar a pasta dos .deb?" "rm -r $diretorioBaixaDebs"
}
