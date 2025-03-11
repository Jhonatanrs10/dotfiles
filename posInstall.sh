#!/usr/bin/bash
DATANOW=$(date "+[%d-%m-%Y][%H-%M]")
## MY BASES ##
myBaseLightdm="lightdm-gtk-greeter lightdm-gtk-greeter-settings lightdm"
myBaseSddm="sddm"
myBaseXfce4="xfce4 xfce4-goodies xfce4-docklike-plugin"
myBaseKde="dolphin dolphin-plugins dragon elisa kdeconnect filelight gwenview leafpad okular kcalc konsole plasma-meta"
myBaseGnome="gnome gnome-tweaks"
myBaseHyprland="hyprland wofi waybar hyprlock hyprpicker wl-clipboard grim slurp azote swaybg polkit-gnome acpilight nwg-look lxappearance xfce4-taskmanager gpicview font-manager pcmanfm galculator system-config-printer xreader rhythmbox dragon kdeconnect gnome-keyring seahorse leafpad network-manager-applet pavucontrol blueman"
myBaseBspwm="bspwm sxhkd polkit-gnome polybar rofi picom nitrogen acpilight scrot xcolor nwg-look lxappearance lxrandr xfce4-taskmanager gpicview xfce4-power-manager font-manager pcmanfm galculator system-config-printer xreader rhythmbox dragon kdeconnect gnome-keyring seahorse leafpad network-manager-applet pavucontrol blueman"
myBaseI3wm="i3 i3lock i3status dmenu polkit-gnome polybar rofi picom nitrogen acpilight scrot xcolor nwg-look lxappearance lxrandr xfce4-taskmanager gpicview xfce4-power-manager font-manager pcmanfm galculator system-config-printer xreader rhythmbox dragon kdeconnect gnome-keyring seahorse leafpad network-manager-applet pavucontrol blueman"
myBaseGlobalApps="gimp inkscape shotcut code neovim qbittorrent mpv gparted chromium alacritty bitwarden discord ark"
myBaseSteam="steam"
myBaseMangoHud="mangohud lib32-mangohud"
myBaseGamescope="gamemode lib32-gamemode gamescope"
myBaseOBS="app/com.obsproject.Studio/x86_64/stable runtime/com.obsproject.Studio.Plugin.MoveTransition/x86_64/stable"
myBaseRetroarch="retroarch retroarch-assets-xmb retroarch-assets-ozone libretro-snes9x libretro-mgba libretro-beetle-psx"
##
myBaseKernel="base linux linux-firmware intel-ucode sof-firmware"
myBaseBootloader="grub efibootmgr os-prober"
myBaseFileSystem="ntfs-3g exfat-utils dosfstools"
myBaseNetwork="networkmanager"
myBaseFirewall="gufw"
myBaseUtilitys="nano fastfetch stow curl jq imagemagick cmatrix htop xsel pacman-contrib base-devel git ffmpeg fwupd samba udisks2 gvfs gvfs-mtp gvfs-smb polkit net-tools joyutils man-db wireless_tools"
myBaseNvidia="nvidia-open nvidia-settings nvidia-utils lib32-nvidia-utils libva-nvidia-driver cuda opencl-nvidia lib32-opencl-nvidia vdpauinfo clinfo"
myBaseBluetooth="bluez bluez-tools bluez-utils"
myBaseAudioPipeware="pipewire pipewire-alsa pipewire-audio pipewire-jack pipewire-pulse"
myBaseAudioPulse="pulseaudio pulseaudio-bluetooth"
myBaseCodecs="gst-plugins-ugly gst-plugins-good gst-plugins-base gst-plugins-bad gst-libav gstreamer"
myBaseXorg="xorg xorg-xsetroot xorg-xhost"
myBaseWayland="wayland gl-wayland"
myBaseIcons="papirus-icon-theme"
myBaseThemes="breeze-gtk capitaine-cursors"
myBaseFonts="gnu-free-fonts ttf-liberation noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-font-awesome"
myBaseRar="bzip2 cpio gzip lha xz lzop p7zip tar unace unrar zip unzip"
myBaseNotify="libnotify dunst"
myBaseDaemons="notification-daemon power-profiles-daemon"
myBaseFlatpak="flatpak"
myBaseShell="bash bash-completion"
##
myFullBase="$myBaseKernel $myBaseBootloader $myBaseFileSystem $myBaseNetwork $myBaseFirewall $myBaseUtilitys $myBaseBluetooth $myBaseAudioPipeware $myBaseCodecs $myBaseXorg $myBaseWayland $myBaseIcons $myBaseThemes $myBaseFonts $myBaseRar $myBaseNotify $myBaseDaemons $myBaseFlatpak $myBaseShell"

## LIB FUNCTIONS ##

lightdmConfig(){
    echo "[greeter]
theme-name = Breeze-Dark
icon-theme-name = Papirus-Dark
cursor-theme-name = capitaine-cursors
indicators = ~session;~spacer;~clock;~spacer;~power
background = /usr/share/backgrounds/main.png
font-name = Freemono 10" | sudo tee -a /etc/lightdm/lightdm-gtk-greeter.conf
}
sambaSetup(){
    echo "Samba Config
[1]Yes [2]No"
    read resp
    case $resp in
        1)
        sudo mv /etc/samba/smb.conf /etc/samba/smb-bkp$DATANOW.conf
        sudo smbpasswd -a $USER
        mkdir -p $HOME/Samba/User
        sudo chmod 777 $HOME/Samba
        sudo mkdir -p /home/samba
        sudo chmod 777 /home/samba
        echo "[global]
    workgroup = WORKGROUP
    netbios name = Samba
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
    create mode = 0777" | sudo tee -a /etc/samba/smb.conf
        ln -s /home/samba $HOME/Samba/Guest
        ;;
        *)
        ;;
    esac
}

enableSystemctl(){
    echo "Ativar $1?
Options: [1]Yes, [2]No"
    read resp
    case $resp in
		1)sudo systemctl enable $1 --now;;
        2)sudo systemctl disable $1;;
		*)
	esac
}

packagesManager(){
	clear
	echo "[PACKAGES]
[$1]	
Options: [1]Pacman, [2]Yay, [3]pamac, [4]Flatpak, [5]Apt
to uninstall for example a Pacman Package put [0] before option. Ex: [01]"
	read resp

	case $resp in
		1)sudo pacman -S $1 --needed;;
		2)yay -S $1 --needed;;
		3)sudo pamac install $1;;
		4)flatpak install $1;;
		5)sudo apt install $1;;
		01)for pacote in $1; do sudo pacman -R --noconfirm $pacote; done ;;
		02)for pacote in $1; do yay -R --noconfirm $pacote; done ;;
		03)for pacote in $1; do sudo pamac remove --no-confirm $pacote; done ;;
		04)for pacote in $1; do flatpak remove -y $pacote; done ;;
		05)for pacote in $1; do sudo apt remove -y $pacote; done ;;
		*)
	esac
	#sleep 5
}

myBaseI3Touchpad(){
    sudo mkdir -p /etc/X11/xorg.conf.d && sudo tee <<'EOF' /etc/X11/xorg.conf.d/90-touchpad.conf 1> /dev/null
Section "InputClass"
Identifier "touchpad"
MatchIsTouchpad "on"
Driver "libinput"
Option "Tapping" "on"
EndSection
EOF
}

installVirtManager(){
    packagesManager "qemu libvirt ebtables dnsmasq bridge-utils openbsd-netcat virt-manager" "VirtManager"
    enableSystemctl "libvirtd"  
    sudo virsh net-autostart default
    #sudo virsh net-start default  
}

myBaseI3Backlight(){
    #sudo chmod +s /usr/bin/light
    echo 'ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp wheel $sys$devpath/brightness", RUN+="/bin/chmod g+w $sys$devpath/brightness"' | sudo tee /etc/udev/rules.d/backlight.rules
    #criarArq 'light' "$HOME/.config/i3/brightness"
}

## SCRIPT FUNCTIONS ##
myBasePosInstall(){
    echo "INSTALL MYBASE I3WM ?
Options: [1]Yes, [2]No"
    read resp
	case $resp in
		1)
            packagesManager "$myFullBase"
            packagesManager "$myBaseI3wm"
            packagesManager "$myBaseLightdm"
            lightdmConfig
            #https://github.com/lutris/docs/blob/master/InstallingDrivers.md#arch--manjaro--other-arch-linux-derivatives
            #causa crash no gdm o pacote: nvidia-dkms
            #https://codigocristo.github.io/driver_nvidia.html
            packagesManager "$myBaseNvidia"
            sudo rm -f /usr/share/applications/rofi*
            if [[ -e "/usr/share/applications/xfce4-power-manager-settings.desktop" ]]; then
                sudo sed -i 's/OnlyShowIn=XFCE;//g' /usr/share/applications/xfce4-power-manager-settings.desktop
            fi  
            myBaseI3Backlight
            myBaseI3Touchpad
            enableSystemctl "smb"
            enableSystemctl "nmb"
            enableSystemctl "bluetooth"
            enableSystemctl "NetworkManager"
            enableSystemctl "power-profiles-daemon"
            enableSystemctl "lightdm"
            sambaSetup 
            ;;
		*)
	esac
}

myBaseGrub(){
        echo "Grub Config
Options: [1]Yes, [2]No"
    read resp
	case $resp in
		1)
            sudo cp /etc/default/grub /etc/default/grub$DATANOW.bkp
            sudo cp /boot/grub/grub.cfg /boot/grub/grub$DATANOW.cfg.bkp
            packagesManager "os-prober"
            sudo grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
            sudo sed -i "/GRUB_DISABLE_OS_PROBER=false/"'s/^#//' /etc/default/grub
            sudo grub-mkconfig -o /boot/grub/grub.cfg
            ;;
        *)
        ;;
    esac
}

myBasePacman(){
     echo "Pacman Config
Options: [1]Yes, [2]No"
    read resp
	case $resp in
		1)
            sudo cp /etc/pacman.conf /etc/pacman$DATANOW.conf.bkp
            sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 10\nILoveCandy\nColor/g' /etc/pacman.conf
            sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
            sudo pacman -Syyu
        ;;
        *)
        ;;
    esac
}

myBaseMountNTFS(){
    echo "Mount /media/homec?
Options: [1]Yes, [2]No"
    read resp
	case $resp in
		1)
            sudo fdisk -l
            echo "Digite o caminho do disco Ex.: /dev/sdb1"
            read DEVSD
            sudo cp /etc/fstab /etc/fstab$DATANOW.bkp
            sudo mkdir -p /media/homec
            #id -u
            #id -g
            sudo tee -a /etc/fstab <<< '# '$DEVSD' 
UUID='$(sudo blkid -s UUID -o value $DEVSD)' /media/homec ntfs uid='$(id -u)',gid='$(id -g)',rw,user,exec,umask=000 0 0'
            cat /etc/fstab
            sleep 5
            #rm -r ~/.steam/steam/steamapps/compatdata
            #mkdir -p ~/.steam/steam/steamapps/compatdata
            #ln -s ~/.steam/steam/steamapps/compatdata /media/gamedisk/Steam/steamapps/
            ;;
        *)
        ;;
    esac
}

myBaseYay(){
    #pacman -Sy --needed git base-devel
    cd $HOME
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
}

myBaselnHome(){
    echo "Gerar /media/homec links ?
Options: [1]Yes, [2]No"
    read resp
	case $resp in
		1)
        ln -s /media/homec/Desktop $HOME
        ln -s /media/homec/Documents $HOME
        ln -s /media/homec/Downloads $HOME
        ln -s /media/homec/Pictures $HOME
        ln -s /media/homec/Videos $HOME
        ln -s /media/homec/Music $HOME
        ln -s /media/homec/Heroic $HOME
        ;;
        *)
        ;;
    esac
    
}

##MENU OPTIONS##

echo "
 [1]Pos Install
 [2]Configure Grub Config
 [3]Configure Pacman Config
 [4]Configure Mount NTFS Config
 [5]Configure lnHome
 [6]Install Yay
 [7]Install OBS
 [8]Install Steam
 [9]Install MangoHud
[10]Install Retroarch
[11]Install VirtManager
"
read option
case $option in
    1)myBasePosInstall;;
    2)myBaseGrub;;
    3)myBasePacman;;
    4)myBaseMountNTFS;;
    5)myBaselnHome;;
    6)myBaseYay;;
    7)packagesManager "$myBaseOBS";;
    8)packagesManager "$myBaseSteam";;
    9)packagesManager "$myBaseMangoHud";;
    10)packagesManager "$myBaseRetroarch";;
    11)installVirtManager;;
    *);;
esac


