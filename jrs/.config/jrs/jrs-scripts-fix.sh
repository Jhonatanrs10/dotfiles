#!/bin/bash

faillock_user() {
	echo "Digite o nome do usuario locked para o reset:"
	read resp
	faillock --user $resp --reset
}

repair_package_manager() {
	echo "[REPAIR PACKAGES MANAGER]
Options: [1]Apt [2]Pacman"
	read resp
	case $resp in
	1)
		sudo dpkg --configure -a
		sudo apt --fix-broken install -y
		;;
	2)
		sudo rm /var/lib/pacman/db.lck
		;;
	*) ;;
	esac
}

time_ntp() {
	sudo timedatectl set-ntp true
	sudo hwclock --systohc
}