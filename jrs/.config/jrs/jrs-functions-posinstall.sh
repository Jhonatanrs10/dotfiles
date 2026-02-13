#!/bin/bash

pacmanSetup() {
	echo "PACMAN
Options: [1]Configure, [2]No"
	read resp
	case $resp in
	1)
		sudo cp /etc/pacman.conf /etc/pacman$DATANOW.conf.bkp
		sudo sed -i 's/ParallelDownloads = 5/ParallelDownloads = 10\nILoveCandy\nColor/g' /etc/pacman.conf
		sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
		sudo pacman -Syyu
		;;
	*) ;;
	esac
}

yaySetup() {
	echo "YAY
Options: [1]Configure, [2]No"
	read resp
	case $resp in
	1)
		sudo pacman -S --needed git base-devel
		cd $HOME
		git clone https://aur.archlinux.org/yay.git
		cd yay
		makepkg -si
		;;
	*) ;;
	esac
}

grubSetup() {
	echo "GRUB
Options: [1]Configure, [2]No"
	read resp
	case $resp in
	1)
		packagesManager "$myBaseBootloader"
		sudo cp /etc/default/grub /etc/default/grub$DATANOW.bkp
		sudo cp /boot/grub/grub.cfg /boot/grub/grub$DATANOW.cfg.bkp
		sudo grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
		sudo sed -i "/GRUB_DISABLE_OS_PROBER=false/"'s/^#//' /etc/default/grub
		sudo grub-mkconfig -o /boot/grub/grub.cfg
		;;
	*) ;;
	esac
}

kernelSetup() {
	echo "KERNEL
[1]Linux [2]Linux-lts [3]Linux-zen"
	read resp
	case $resp in
	1) packagesManager "$myBaseKernel" ;;
	2) packagesManager "$myBaseKernelLts" ;;
	3) packagesManager "$myBaseKernelZen" ;;
	*) ;;
	esac
}

driverSetup() {
	echo "DRIVER
[1]Configure [2]No"
	read resp
	case $resp in
	1) installVideoDriver ;;
	*) ;;
	esac
}

audioSetup() {
	echo "AUDIO
[1]Pipeware [2]PulseAudio"
	read resp
	case $resp in
	1) packagesManager "$myBaseAudioPipeware" ;;
	2) packagesManager "$myBaseAudioPulse" ;;
	*) ;;
	esac
}

baseSetup() {
	echo "BASE
[1]Configure [2]No"
	read resp
	case $resp in
	1)
		packagesManager "$myBaseBootloader $myBaseFileSystem $myBaseNetwork $myBaseFirewall $myBaseBluetooth $myBaseCodecs $myBaseIcons $myBaseThemes $myBaseFonts $myBaseRar $myBaseNotify $myBaseDaemons $myBaseFlatpak $myBaseShell $myBaseUtilitys $myBaseXorg $myBaseWayland"
		;;
	*) ;;
	esac
}

appsSetup() {
	echo "APPS
[1]Configure [2]No"
	read resp
	case $resp in
	1)
		packagesManager "$myBaseBrowser $myBaseAudioApp $myBaseVideoApp $myBaseGraphicDesignApp $myBaseSecurityApp $myBaseDiskManagerApp $myBaseOfficeApp $myBaseVideoEditorApp $myBaseCodingApp $myBaseTorrentApp $myBaseConnectApp"
		packagesManager "$myBaseDiscordApp"
		packagesManager "$myBaseSteam"
		packagesManager "$myBaseMinecraft"
		packagesManager "$myBaseHeroic"
		packagesManager "$myBaseMangoHud"
		packagesManager "$myBaseGamescope"
		packagesManager "$myBaseRetroarch"
		packagesManager "$myBaseOBS"
		packagesManager "$myBaseStreamOverlay"
		;;
	*) ;;
	esac
}

startSetup() {
	enableSystemctl "bluetooth"
	enableSystemctl "NetworkManager"
	enableSystemctl "power-profiles-daemon"
	enableSystemctl "sshd"
}

sambaSetup() {
	echo "SAMBA
[1]Configure [2]No"
	read -r resp
	case $resp in
	1)
		sudo pacman -S --needed samba
		sudo smbpasswd -a "$USER"
		sudo smbpasswd -e "$USER"

		RAND=$(cat /dev/urandom | tr -dc 'A-Z0-9' | head -c 6)
		NETBIOS_NAME="Samba$RAND"

		echo "Using NetBIOS name: $NETBIOS_NAME"

		sudo mv /etc/samba/smb.conf /etc/samba/smb-bkp$DATANOW.conf

		mkdir -p "$HOME/Samba/User"
		sudo chmod 777 "$HOME/Samba"
		sudo mkdir -p /home/samba
		sudo chmod 777 /home/samba

		echo "[global]
    workgroup = WORKGROUP
    preferred master = no
    local master = no
    domain master = no
    netbios name = $NETBIOS_NAME
    server string = Samba Server
    server role = standalone server
    security = user
    map to guest = bad user
    guest account = nobody
    log file = /var/log/samba/%m
    log level = 1
    dns proxy = no
[printers]
    comment = All Printers
    path = /usr/spool/samba
    browsable = no
    guest ok = no
    writable = no
    printable = yes
[User]
    comment = Pasta Compartilhada na Rede
    path = $HOME/Samba/User
    browseable = yes
    read only = yes
    guest ok = no
    write list = $USER
    force directory mode = 0777
    directory mode = 0777
    create mode = 0777
[Guest]
    comment = Pasta Compartilhada na Rede
    path = /home/samba
    browseable = yes
    read only = yes
    guest ok = yes
    write list = $USER
    force directory mode = 0777
    directory mode = 0777
    create mode = 0777" | sudo tee /etc/samba/smb.conf >/dev/null

		ln -s /home/samba "$HOME/Samba/Guest"
		enableSystemctl "smb"
		enableSystemctl "nmb"
		#sudo systemctl restart smbd nmbd
		#sudo useradd -m samba
		#sudo passwd samba
		;;
	*) ;;
	esac
}

configsSetup() {
	echo "CONFIGS
[1]Configure [2]No"
	read resp
	case $resp in
	1)
		flatpak override --user --filesystem=~/.icons:ro --filesystem=~/.local/share/icons:ro
		sudo rm -f /usr/share/applications/rofi*
		myBaseI3Backlight
		myBaseI3Touchpad
		lidSwitchIgnore
		criaAtalho "Wiremix Audio" "Audio Tui" "wiremix" "$HOME" "true" "Wiremix" "pavucontrol"
		criaAtalho "Syncthing" "Sync Folders" "xdg-open http://localhost:8384/" "$HOME" "false" "Syncthing" "syncthing"
		setup_file_bashrc
		setup_file_bash_profile
		setup_file_profile
		default-xdg-mime
		;;
	*) ;;
	esac
}

desktopSetup() {
	echo "DESKTOP
[1]Hyprland [2]I3wm [3]Gnome [4]KDE [5]Xfce"
	read resp
	case $resp in
	1)
		packagesManager "$myBaseHyprland $wmDisplayManager $wmApplicationLauncher $wmAudioControl $wmBacklightControl $wmBluetoothControl $wmNetworkManager $wmKeyring $wmDiskStatus $wmMusicPlayer $wmPrinters $wmCalculator $wmFontManager $wmImageViewer $wmAppearance $wmPolkit $wmBaseFileManager $wmBaseTerminal $wmBasePdfApp"
		#hyprland
		;;
	2)
		packagesManager "$myBaseI3wm $wmDisplayManager $wmApplicationLauncher $wmAudioControl $wmBacklightControl $wmBluetoothControl $wmNetworkManager $wmKeyring $wmDiskStatus $wmMusicPlayer $wmPrinters $wmCalculator $wmFontManager $wmImageViewer $wmAppearance $wmPolkit $wmBaseFileManager $wmBaseTerminal $wmBasePdfApp"
		#startx /usr/bin/i3
		;;
	3)
		packagesManager "$myBaseGnome"
		enableSystemctl "gdm"
		;;
	4)
		packagesManager "$myBaseKde"
		enableSystemctl "sddm"
		;;
	5)
		packagesManager "$myBaseXfce4"
		enableSystemctl "lightdm"
		;;
	*) ;;
	esac
}

############
###OUTROS###
############

lightdmConfig() {
	echo "[greeter]
theme-name = Breeze-Dark
icon-theme-name = Papirus-Dark
cursor-theme-name = Adwaita
indicators = ~session;~spacer;~clock;~spacer;~power
background = /usr/share/backgrounds/main.png
font-name = Caskaydia Mono Nerd Font 11" | sudo tee -a /etc/lightdm/lightdm-gtk-greeter.conf
}

myBaseI3Touchpad() {
	sudo mkdir -p /etc/X11/xorg.conf.d && sudo tee /etc/X11/xorg.conf.d/90-touchpad.conf <<'EOF' 1>/dev/null
Section "InputClass"
Identifier "touchpad"
MatchIsTouchpad "on"
Driver "libinput"
Option "Tapping" "on"
EndSection
EOF
}

myBaseI3Backlight() {
	#sudo chmod +s /usr/bin/light
	echo 'ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp wheel $sys$devpath/brightness", RUN+="/bin/chmod g+w $sys$devpath/brightness"' | sudo tee /etc/udev/rules.d/backlight.rules
	#criarArq 'light' "$HOME/.config/i3/brightness"
}

lidSwitchIgnore() {
	sudo sed -i 's/^#HandleLidSwitch=suspend/HandleLidSwitch=ignore/' /etc/systemd/logind.conf
	sudo sed -i 's/^HandleLidSwitch=suspend/HandleLidSwitch=ignore/' /etc/systemd/logind.conf
}

setup_file_bashrc() {
	criarArq "#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ "'$-'" != *i* ]] && return

[[ -f ~/.config/bashconfigs/bash_alias ]] && . ~/.config/bashconfigs/bash_alias
" "$HOME/.bashrc"
}

setup_file_bash_profile() {
	criarArq '#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -f ~/.config/bashconfigs/bash_vars ]] && . ~/.config/bashconfigs/bash_vars

' "$HOME/.bash_profile"
}

setup_file_profile() {
	criarArq 'setxkbmap -model abnt2 -layout br
echo "Xcursor.theme: Adwaita
Xcursor.size: 24" | xrdb -merge' "$HOME/.profile"
}

appPosBluetoothFix() {
	echo "[1]Fix Bluetooth & Network Interference [2]Remove Fix"
	read esco
	if [ "$esco" = "1" ]; then
		sudo tee /etc/modprobe.d/iwlwifi-opt.conf <<<"options iwlwifi bt_coex_active=N"
	elif [ "$esco" = "2" ]; then
		sudo rm /etc/modprobe.d/iwlwifi-opt.conf
	fi
}

appPosTecladoConfig() {
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

appPosTimeNTP() {
	sudo timedatectl set-ntp true
	sudo hwclock --systohc
}

xfce4Config() {
	xfce4-panel --quit
	pkill xfconfd
	rm -rf ~/.config/xfce4/panel
	rm -rf ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
	xfce4-config
	xfce4-panel &
}

gsettingsInactiveOn() {
	xset s on +dpms
	gsettings set org.gnome.desktop.session idle-delay 300
	gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'suspend'
	gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 600
	gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'suspend'
	gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 300
}

gsettingsInactiveOff() {
	xset s off -dpms
	gsettings set org.gnome.desktop.session idle-delay 0
	gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
	gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
	gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
	gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 0
}

default-xdg-mime() {

	xdg-settings set default-web-browser zen-browser.desktop

	xdg-mime default thunar.desktop inode/directory

	xdg-mime default feh.desktop image/jpeg image/png image/gif image/bmp image/webp

	xdg-mime default xreader.desktop application/pdf

	xdg-mime default alacritty.desktop x-scheme-handler/terminal

	xdg-mime default galculator.desktop x-scheme-handler/calc

	xdg-mime default ark.desktop application/zip application/x-tar application/x-7z-compressed application/x-rar

	xdg-mime default cmus.desktop audio/mpeg audio/ogg audio/flac audio/x-wav

	xdg-mime default font-manager.desktop font/ttf font/otf application/x-font-ttf application/x-font-otf
}

defaultInodeDirectory() {
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

hyprlandDiscordX() {
	criaAtalho "DiscordX (Flatpak)" "Discord em Xwayland" "env ELECTRON_OZONE_PLATFORM_HINT= com.discordapp.Discord --no-sandbox" "$HOME" "false" "discordFlatpak" "discord"
	criaAtalho "DiscordX (Pacman)" "Discord em Xwayland" "env ELECTRON_OZONE_PLATFORM_HINT= discord --no-sandbox" "$HOME" "false" "discordPacman" "discord"
}

appPosManualConfig() {
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

installRetroArch() {
	packagesManager "$myBaseRetroarch"
}

##########################

myBasePosInstall() {
	pacmanSetup
	yaySetup
	kernelSetup
	audioSetup
	baseSetup
	driverSetup
	appsSetup
	startSetup
	sambaSetup
	configsSetup
	grubSetup
	desktopSetup
}
