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

setup_keyboard() {
	echo "[ARCH] Keyboard BR"
	setxkbmap -model abnt2 -layout br
	#echo "setxkbmap -model abnt2 -layout br" >> ~/.profile
	sudo tee /etc/X11/xorg.conf.d/10-evdev.conf <<<'Section "InputClass"
Identifier "evdev keyboard catchall"
MatchIsKeyboard "on"
MatchDevicePath "/dev/input/event*"
Driver "evdev"
Option "XkbLayout" "br"
Option "XkbVariant" "abnt2"
EndSection'
}

manual_config() {
	echo "---------------------
Configuracoes Manuais
---------------------
[PACMAN]
Remover comentarios em: /etc/pacman.conf
#Color
#ParallelDownloads = 10
ILoveCandy
#[multilib]
#Include = /etc/pacman.d/mirrorlist
---------------------
[GNOME]
Remover comentarios em: /etc/gdm3/custom.conf
#WaylandEnable=false
Apos editar, executar:
sudo systemctl restart gdm3
---------------------
[THEME]
Caso de erro com thema no i3 é so apagar as pastas gtk-* em .config na HOME
---------------------
[NVIDIA]
https://github.com/korvahannu/arch-nvidia-drivers-installation-guide
configurar no Xorg com
sudo nvidia-xconfig
---------------------
[GRUB]
sudo nano /etc/default/grub
remover # da opcao 
#GRUB_DISABLE_OS_PROBER=false
apos isso executar
grub-mkconfig -o /boot/grub/grub.cfg
---------------------
[Steam Linux & Windows]
https://github.com/ValveSoftware/Proton/wiki/Using-a-NTFS-disk-with-Linux-and-Windows
---------------------
[Syncthing]
Para syncronizar todas as pastas devem conter o MESMO: NOME e ID
"
	read enterprasair
}

setup_inode_directory() {
	echo "Default Applications   
[1]Nautilus for FileManager
[2]PCManFM for FileManager
[3]Thunar for FileManager"
	read resp
	case $resp in
	1) xdg-mime default org.gnome.Nautilus.desktop inode/directory ;;
	2) xdg-mime default pcmanfm.desktop inode/directory ;;
	3) xdg-mime default thunar.desktop inode/directory ;;
	*) ;;
	esac
}

setup_xdg_mime() {

	#Variavel para browser setada em jrs-bash-exports.sh
	#xdg-settings set default-web-browser zen-browser.desktop

	xdg-mime default thunar.desktop inode/directory

	xdg-mime default feh.desktop image/jpeg image/png image/gif image/bmp image/webp

	xdg-mime default xreader.desktop application/pdf

	xdg-mime default alacritty.desktop x-scheme-handler/terminal

	xdg-mime default galculator.desktop x-scheme-handler/calc

	xdg-mime default ark.desktop application/zip application/x-tar application/x-7z-compressed application/x-rar

	xdg-mime default cmus.desktop audio/mpeg audio/ogg audio/flac audio/x-wav

	xdg-mime default font-manager.desktop font/ttf font/otf application/x-font-ttf application/x-font-otf
}

setup_bluetooth() {
	echo "[1]Fix Bluetooth & Network Interference [2]Remove Fix"
	read esco
	if [ "$esco" = "1" ]; then
		sudo tee /etc/modprobe.d/iwlwifi-opt.conf <<<"options iwlwifi bt_coex_active=N"
	elif [ "$esco" = "2" ]; then
		sudo rm /etc/modprobe.d/iwlwifi-opt.conf
	fi
}

setup_lid_switch_ignore() {
	sudo sed -i 's/^#HandleLidSwitch=suspend/HandleLidSwitch=ignore/' /etc/systemd/logind.conf
	sudo sed -i 's/^HandleLidSwitch=suspend/HandleLidSwitch=ignore/' /etc/systemd/logind.conf
}

setup_i3_backlight() {
	#sudo chmod +s /usr/bin/light
	echo 'ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp wheel $sys$devpath/brightness", RUN+="/bin/chmod g+w $sys$devpath/brightness"' | sudo tee /etc/udev/rules.d/backlight.rules
}

lightdm_config() {
	echo "[greeter]
theme-name = Breeze-Dark
icon-theme-name = Papirus-Dark
cursor-theme-name = Adwaita
indicators = ~session;~spacer;~clock;~spacer;~power
background = /usr/share/backgrounds/main.png
font-name = Caskaydia Mono Nerd Font 11" | sudo tee -a /etc/lightdm/lightdm-gtk-greeter.conf
}

setup_i3_touchpad() {
	sudo mkdir -p /etc/X11/xorg.conf.d && sudo tee /etc/X11/xorg.conf.d/90-touchpad.conf <<'EOF' 1>/dev/null
Section "InputClass"
Identifier "touchpad"
MatchIsTouchpad "on"
Driver "libinput"
Option "Tapping" "on"
EndSection
EOF
}