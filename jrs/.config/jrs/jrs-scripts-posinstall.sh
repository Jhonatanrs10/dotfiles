#!/bin/bash

source $HOME/.dotfiles/jrs/.config/jrs/jrs-scripts-packages.sh
DATANOW=$(date "+[%d-%m-%Y][%H-%M]")

setup_pacman() {
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

setup_yay() {
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

setup_grub() {
	echo "GRUB
Options: [1]Configure, [2]No"
	read resp
	case $resp in
	1)
		sudo pacman -S $myBaseBootloader --needed
		sudo cp /etc/default/grub /etc/default/grub$DATANOW.bkp
		sudo cp /boot/grub/grub.cfg /boot/grub/grub$DATANOW.cfg.bkp
		sudo grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
		sudo sed -i "/GRUB_DISABLE_OS_PROBER=false/"'s/^#//' /etc/default/grub
		sudo grub-mkconfig -o /boot/grub/grub.cfg
		;;
	*) ;;
	esac
}

setup_kernel() {
	echo "KERNEL
[1]Linux [2]Linux-lts [3]Linux-zen"
	read resp
	case $resp in
	1) sudo pacman -S $myBaseKernel --needed ;;
	2) sudo pacman -S $myBaseKernelLts --needed ;;
	3) sudo pacman -S $myBaseKernelZen --needed ;;
	*) ;;
	esac
}

setup_driver() {
	source $HOME/.dotfiles/jrs/.config/jrs/jrs-scripts-video-driver.sh
	echo "DRIVER
[1]Configure [2]No"
	read resp
	case $resp in
	1) installVideoDriver ;;
	*) ;;
	esac
}

setup_audio() {
	echo "AUDIO
[1]Pipeware [2]PulseAudio"
	read resp
	case $resp in
	1) sudo pacman -S $myBaseAudioPipeware --needed ;;
	2) sudo pacman -S $myBaseAudioPulse --needed ;;
	*) ;;
	esac
}

setup_base() {
	echo "BASE
[1]Configure [2]No"
	read resp
	case $resp in
	1) sudo pacman -Syu $myBaseBootloader $myBaseFileSystem $myBaseNetwork $myBaseFirewall $myBaseBluetooth $myBaseCodecs $myBaseIcons $myBaseThemes $myBaseFonts $myBaseRar $myBaseNotify $myBaseDaemons $myBaseFlatpak $myBaseShell $myBaseUtilitys $myBaseXorg $myBaseWayland --needed ;;
	*) ;;
	esac
}

setup_apps() {
	echo "APPS
[1]Configure [2]No"
	read resp
	case $resp in
	1) sudo pacman -S $myBaseBrowser $myBaseAudioApp $myBaseVideoApp $myBaseGraphicDesignApp $myBaseSecurityApp $myBaseDiskManagerApp $myBaseOfficeApp $myBaseVideoEditorApp $myBaseCodingApp $myBaseTorrentApp $myBaseConnectApp --needed ;;
	*) ;;
	esac
}

setup_start() {
	echo "START
[1]Configure [2]No"
	read resp
	case $resp in
	1)
		sudo systemctl enable "bluetooth" --now
		sudo systemctl enable "NetworkManager" --now
		sudo systemctl enable "power-profiles-daemon" --now
		sudo systemctl enable "sshd" --now
		;;
	*) ;;
	esac

}

setup_samba() {
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
		sudo systemctl enable "smb" --now
		sudo systemctl enable "nmb" --now
		#sudo systemctl restart smbd nmbd
		#sudo useradd -m samba
		#sudo passwd samba
		;;
	*) ;;
	esac
}

setup_configs() {
	source $HOME/.dotfiles/jrs/.config/jrs/jrs-scripts-fix.sh
	source $HOME/.dotfiles/jrs/.config/jrs/jrs-scripts-create-file.sh
	source $HOME/.dotfiles/jrs/.config/jrs/jrs-scripts-create-shortcut.sh

	echo "CONFIGS
[1]Configure [2]No"
	read resp
	case $resp in
	1)
		flatpak override --user --filesystem=~/.icons:ro --filesystem=~/.local/share/icons:ro
		sudo rm -f /usr/share/applications/rofi*
		sudo rm -f /usr/share/applications/wiremix*
		setup_i3_backlight
		setup_i3_touchpad
		setup_lid_switch_ignore
		setup_xdg_mime
		create_shortcut_desktop "Wiremix Audio" "Audio Tui" "wiremix --tab output" "$HOME" "true" "Wiremix" "pavucontrol"
		create_shortcut_desktop "Syncthing" "Sync Folders" "xdg-open http://localhost:8384/" "$HOME" "false" "Syncthing" "syncthing"
		create_shortcut_desktop "SteamOS (Exec)" "Steam with gamescope like SteamOS" "bash $HOME/.config/jrs/jrs-exec-steam-gamescope.sh" "$HOME" "false" "ExecSteamGamescope" "steam"
		create_shortcut_desktop "Live Setup (Exec)" "Apps for live stream" "bash $HOME/.config/jrs/jrs-exec-live-setup.sh" "$HOME" "false" "ExecLiveSetup" "obs"
		create_shortcut_desktop "DiscordX (Flatpak)" "Discord em Xwayland" "env ELECTRON_OZONE_PLATFORM_HINT= com.discordapp.Discord --no-sandbox" "$HOME" "false" "discordFlatpak" "discord"
		create_shortcut_desktop "DiscordX (Pacman)" "Discord em Xwayland" "env ELECTRON_OZONE_PLATFORM_HINT= discord --no-sandbox" "$HOME" "false" "discordPacman" "discord"
		create_file_bashrc
		create_file_bash_profile
		create_file_profile
		;;
	*) ;;
	esac
}

setup_desktop() {
	echo "DESKTOP
[1]Hyprland [2]I3wm [3]Gnome [4]KDE [5]Xfce"
	read resp
	case $resp in
	1)
		sudo pacman -S $myBaseHyprland $wmApplicationLauncher $wmAudioControl $wmBacklightControl $wmBluetoothControl $wmNetworkManager $wmKeyring $wmDiskStatus $wmMusicPlayer $wmPrinters $wmCalculator $wmFontManager $wmImageViewer $wmAppearance $wmPolkit $wmBaseFileManager $wmBaseTerminal $wmBasePdfApp $wmBaseScreenshotApp --needed
		#hyprland
		;;
	2)
		sudo pacman -S $myBaseI3wm $wmApplicationLauncher $wmAudioControl $wmBacklightControl $wmBluetoothControl $wmNetworkManager $wmKeyring $wmDiskStatus $wmMusicPlayer $wmPrinters $wmCalculator $wmFontManager $wmImageViewer $wmAppearance $wmPolkit $wmBaseFileManager $wmBaseTerminal $wmBasePdfApp $wmBaseScreenshotApp --needed
		#startx /usr/bin/i3
		;;
	3)
		sudo pacman -S $myBaseGnome --needed
		sudo systemctl enable "gdm"
		;;
	4)
		sudo pacman -S $myBaseKde --needed
		sudo systemctl enable "sddm"
		;;
	5)
		sudo pacman -S $myBaseXfce4 --needed
		sudo systemctl enable "lightdm"
		;;
	*) ;;
	esac
}

setup_stow() {
	echo "DOTFILES
[1]Configure [2]No"
	read resp
	case $resp in
	1)
		# Definição dos caminhos
		DOTFILES_DIR="$HOME/.dotfiles"
		CONFIG_DIR="$HOME/.config"
		BKP_DIR="$HOME/.config/dotfiles_bkp"

		# Garante que a pasta de backup existe
		mkdir -p "$BKP_DIR"

		echo "--- Iniciando Movimentação para Backup ---"

		# Entra na pasta de dotfiles para listar o que você já gerencia
		cd "$DOTFILES_DIR" || {
			echo "Erro: Pasta $DOTFILES_DIR não encontrada."
			exit 1
		}

		# Loop apenas pelas pastas (*/) dentro de .dotfiles
		for folder in */; do
			# Remove a barra '/' do final do nome da pasta (ex: 'nvim/' vira 'nvim')
			folder=${folder%/}

			# Verifica se essa pasta existe no seu ~/.config
			if [ -d "$CONFIG_DIR/$folder" ]; then
				echo "Movendo: $CONFIG_DIR/$folder  ->  $BKP_DIR/"
				# O comando de mover propriamente dito
				mv "$CONFIG_DIR/$folder" "$BKP_DIR/"
			else
				echo "Pulando: '$folder' (não encontrada em $CONFIG_DIR)"
			fi
		done

		cd $DOTFILES_DIR
		stow */
		rm $HOME/.config/hypr/colors.conf
		bash $HOME/.config/jrs/jrs-rofi-set-theme.sh
		echo "--- Processo concluído! ---"
		exit 0
		;;
	*) ;;
	esac
}

posinstall() {
	setup_pacman
	setup_yay
	setup_kernel
	setup_audio
	setup_base
	setup_driver
	setup_apps
	setup_start
	setup_samba
	setup_configs
	setup_grub
	setup_desktop
	setup_stow
}
