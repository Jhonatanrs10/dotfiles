#!/bin/bash

sourceFolder() {
	for src in $(ls $1); do
		source $1/$src
		#echo "$1/$src"
	done
	#sleep 10
}

forLength() {
	echo $1
	read txtForLength
	if [ "$txtForLength" = "" ]; then
		txtForLength=$3
		echo "Valor vazio, Default $txtForLength"
	elif [ "$(expr length $txtForLength)" = $2 ]; then
		echo "Escolha $txtForLength"
	else
		txtForLength=$3
		echo "Necessario 6 digitos, Default $txtForLength"
	fi
}
#forLength "Titulo" "numero/tamanho/length" "default value"

options_list() {
	zOptionsList="/tmp/zOptionsList.txt"
	cd $1
	ls $3 . >$zOptionsList
	cd $OLDPWD
	echo "[Options List] DIGITE O NUMERO DA SUA ESCOLHA:"
	cat -n $zOptionsList
	echo "[Options List]"
	read zOptionL
	#pega conteudo do arquivo | numera o conteudo por linha | escolhe uma linha | elimina o numero da linha e deixa so o conteudo
	export $2=$(cat $zOptionsList | grep -n ^ | grep ^$zOptionL | cut -d: -f2)
}

baixaArq() {
	if [ $1 = 'diretorio' ]; then
		wget -c -P "$3" "$2"
	elif [ $1 = 'diretorioNome' ]; then
		wget -c "$2" -O "$3"
	fi
}
#baixaArq "diretorioNome Ou diretorio" "links" "diretorio/Nome.tar"

rofi_or_wofi() {
	# Detect session type and choose appropriate menu
	if [ "$XDG_SESSION_TYPE" = "x11" ] && command -v rofi &>/dev/null; then
		menu_cmd="rofi -dmenu -i -p Profiles"
	elif [ "$XDG_SESSION_TYPE" = "wayland" ] && command -v wofi &>/dev/null; then
		menu_cmd="wofi --dmenu --prompt=Options"
	else
		echo "ERROR: No suitable menu found" >&2
		exit 1
	fi
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
	#criarArq 'light' "$HOME/.config/i3/brightness"
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
