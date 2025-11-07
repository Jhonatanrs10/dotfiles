#!/usr/bin/env sh
addArchi386(){
	echo -e '[INFO] - ADCIONANDO ARQUITETURA DE 32 BITS - [INFO]'
	sudo dpkg --add-architecture i386
}

aptUpdate(){
	echo -e "[INFO] - ATUALIZANDO REPOSITORIO E FAZENDO ATUALIZACAO DO SISTEMA - [INFO]"
	sudo apt update && sudo apt dist-upgrade -y
	sudo pacman -Syyuu
}

installDebs(){
	echo -e "[INFO] - INSTALANDO PACOTES DEB - [INFO]"
	sudo dpkg -i $1/*.deb
}

justAptUpdate(){
	echo -e "[INFO] - ATUALIZANDO O REPOSITORIO - [INFO]"
	sudo apt update -y
}

supFlatpakApt(){
    sudo add-apt-repository ppa:flatpak/stable
    sudo apt update
    sudo apt install flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

teste_internet(){
	echo -e "[INFO] - VERIFICANDO CONEXAO COM A REDE - [INFO]"
	if ! ping -c 1 8.8.8.8 -q &> /dev/null; 
	then
	  echo -e "[INFO] - SEM CONEXAO COM INTERNET - [INFO]"
	  exit 1
	else
	  echo -e "[INFO] - CONEXAO COM INTERNET FUNCIONANDO NORMALMENTE - [INFO]"
	fi
}

travas_apt(){
    sudo rm /var/lib/dpkg/lock-frontend
    sudo rm /var/cache/apt/archives/lock
}

installDriverNvidia(){
    aptUpdate
    ubuntu-drivers devices
    echo "Visualizar Drivers: ubuntu-drivers devices
Instalar Drivers: sudo apt install nvidia-driver-X"
}