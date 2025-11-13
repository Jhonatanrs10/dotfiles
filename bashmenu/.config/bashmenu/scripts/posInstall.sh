#!/usr/bin/bash

myBasePosInstall(){
    pacmanSetup
    yaySetup
    grubSetup
    kernelSetup
    driverSetup
    audioSetup
    baseSetup
    appsSetup
    startSetup
    sambaSetup
    configsSetup
    desktopSetup
    
}

pacmanSetup(){
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
        *)
        ;;
    esac
}

yaySetup(){
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
        *)
        ;;
    esac
}

grubSetup(){
        echo "GRUB
Options: [1]Configure, [2]No"
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

kernelSetup(){
    echo "KERNEL
[1]Linux [2]Linux-lts [3]Linux-zen"
    read resp
	case $resp in
        1)packagesManager "$myBaseKernel";;
        2)packagesManager "$myBaseKernelLts";;
        3)packagesManager "$myBaseKernelZen";;
        *)
    esac
}

driverSetup(){
    echo "DRIVER
[1]Configure [2]No"
    read resp
	case $resp in
        1)installVideoDriver;;
        *)
    esac
}

audioSetup(){
    echo "AUDIO
[1]Pipeware [2]PulseAudio"
    read resp
	case $resp in
        1)packagesManager "$myBaseAudioPipeware";;
        2)packagesManager "$myBaseAudioPulse";;
        *)
    esac
}

baseSetup(){
    echo "BASE
[1]Configure [2]No"
    read resp
	case $resp in
        1)packagesManager "$myBaseBootloader $myBaseFileSystem $myBaseNetwork $myBaseFirewall $myBaseUtilitys $myBaseBluetooth $myBaseCodecs $myBaseXorg $myBaseWayland $myBaseIcons $myBaseThemes $myBaseFonts $myBaseRar $myBaseNotify $myBaseDaemons $myBaseFlatpak $myBaseShell";;
        *)
    esac
}

appsSetup(){
    echo "APPS
[1]Configure [2]No"
    read resp
	case $resp in
        1)packagesManager "$myBaseGlobalApps";;
        *)
    esac
}

startSetup(){
    enableSystemctl "bluetooth"
    enableSystemctl "NetworkManager"
    enableSystemctl "power-profiles-daemon"
    enableSystemctl "sshd"
}

sambaSetup(){
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
    create mode = 0777" | sudo tee /etc/samba/smb.conf > /dev/null

        ln -s /home/samba "$HOME/Samba/Guest"
        enableSystemctl "smb"
        enableSystemctl "nmb"
        #sudo systemctl restart smbd nmbd
        #sudo useradd -m samba
        #sudo passwd samba
        ;;
        *)
        ;;
    esac
}

configsSetup(){
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
            ;;
        *)
    esac
}

desktopSetup(){
    echo "DESKTOP
[1]Hyprland [2]Bspwm [3]I3wm [4]Gnome [5]KDE"
    read resp
	case $resp in
        1)
            packagesManager "$myBaseHyprland"
            enableSystemctl "ly";; 
        2)
            packagesManager "$myBaseBspwm"
            enableSystemctl "ly";; 
        3)
            packagesManager "$myBaseI3wm"
            enableSystemctl "ly";; 
        4)
            packagesManager "$myBaseGnome"
            enableSystemctl "gdm";;
        5)
            packagesManager "$myBaseKde"
            enableSystemctl "sddm";;
        *)
    esac
}

############
###OUTROS###
############

lightdmConfig(){
    echo "[greeter]
theme-name = Breeze-Dark
icon-theme-name = Papirus-Dark
cursor-theme-name = Adwaita
indicators = ~session;~spacer;~clock;~spacer;~power
background = /usr/share/backgrounds/main.png
font-name = Caskaydia Mono Nerd Font 11" | sudo tee -a /etc/lightdm/lightdm-gtk-greeter.conf
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
    packagesManager "$myBaseVirt" "VirtManager"
    enableSystemctl "libvirtd"  
    sudo virsh net-autostart default
    #sudo virsh net-start default  
}

myBaseI3Backlight(){
    #sudo chmod +s /usr/bin/light
    echo 'ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp wheel $sys$devpath/brightness", RUN+="/bin/chmod g+w $sys$devpath/brightness"' | sudo tee /etc/udev/rules.d/backlight.rules
    #criarArq 'light' "$HOME/.config/i3/brightness"
}

myDotfiles() {
    packagesManager "stow"
    cd "$HOME"

    if [ -d "$HOME/.dotfiles" ]; then
        echo "🔄 Diretório .dotfiles já existe. Limpando stow..."
        cd "$HOME/.dotfiles" || return
        stow -D */
    else
        echo "📥 Clonando repositório de dotfiles..."
        git clone https://github.com/Jhonatanrs10/dotfiles
        mv dotfiles/ .dotfiles/
        cd "$HOME/.dotfiles" || return
    fi

    echo "✅ Aplicando stow..."
    stow */
}

lidSwitchIgnore(){
    sudo sed -i 's/^#HandleLidSwitch=suspend/HandleLidSwitch=ignore/' /etc/systemd/logind.conf
    sudo sed -i 's/^HandleLidSwitch=suspend/HandleLidSwitch=ignore/' /etc/systemd/logind.conf
}



myBaseMountNTFS(){
    # somente leitura pode ser o modo de energia do windows em dualboot (modo de reinicialização rapida)
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

## Olds ##

appPosNetwork(){
    echo "[ARCH] Network"
    echo "INSTALAR NETWORKMANAGER"
    packagesManager "networkmanager nm-connection-editor network-manager-applet"
    #sudo systemctl enable NetworkManager.service
    #sudo systemctl start NetworkManager.service --now
    enableSystemctl "NetworkManager"
    #echo "REMOVER IWD (wifi terminal archinstall)"
    #removePacotes "iwd"
}
 
appPosNvidiaDriverProp(){
        #https://github.com/lutris/docs/blob/master/InstallingDrivers.md#arch--manjaro--other-arch-linux-derivatives
        #causa crash no gdm o pacote: nvidia-dkms
        #https://codigocristo.github.io/driver_nvidia.html
        #packagesManager "$myBaseNvidia"
        packagesManager "nvidia-open nvidia-utils lib32-nvidia-utils nvidia-settings"
        echo "https://github.com/korvahannu/arch-nvidia-drivers-installation-guide"
        sleep 10
}    

appPosManualConfig(){ 
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
"
read enterprasair
}

appPosBluetoothFix(){
    echo "[1]Fix Bluetooth & Network Interference [2]Remove Fix"
    read esco
    if [ "$esco" = "1" ]; then
        sudo tee /etc/modprobe.d/iwlwifi-opt.conf <<< "options iwlwifi bt_coex_active=N"
    elif [ "$esco" = "2" ]; then
        sudo rm /etc/modprobe.d/iwlwifi-opt.conf
    fi
}

appPosTecladoConfig(){
    echo "[ARCH] Keyboard BR"
    setxkbmap -model abnt2 -layout br
    #echo "setxkbmap -model abnt2 -layout br" >> ~/.profile
    sudo tee /etc/X11/xorg.conf.d/10-evdev.conf <<< 'Section "InputClass"
Identifier "evdev keyboard catchall"
MatchIsKeyboard "on"
MatchDevicePath "/dev/input/event*"
Driver "evdev"
Option "XkbLayout" "br"
Option "XkbVariant" "abnt2"
EndSection'
}

appPosTimeNTP(){
    sudo timedatectl set-ntp true
    sudo hwclock --systohc
}

gamescopePriorityConf(){
    sudo setcap 'CAP_SYS_NICE=eip' $(which gamescope)
    sudo tee /etc/modprobe.d/nvidia-modeset.conf <<< 'options nvidia_drm modeset=1 fbdev=1'
}

xfce4Config(){
    xfce4-panel --quit
    pkill xfconfd
    rm -rf ~/.config/xfce4/panel
    rm -rf ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
    xfce4-config
    xfce4-panel &
}

gsettingsInactiveOn(){
    xset s on +dpms
    gsettings set org.gnome.desktop.session idle-delay 300
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'suspend'
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 600
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'suspend'
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 300
}

gsettingsInactiveOff(){
    xset s off -dpms
    gsettings set org.gnome.desktop.session idle-delay 0
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 0
}

defaultInodeDirectory(){
    echo "Default Applications   
[1]Nautilus for FileManager
[2]PCManFM for FileManager
[3]Thunar for FileManager"
    read resp
    case $resp in
        1)xdg-mime default org.gnome.Nautilus.desktop inode/directory;;
        2)xdg-mime default pcmanfm.desktop inode/directory;;
        3)xdg-mime default thunar.desktop inode/directory;;
        *)
    esac
}

hyprlandDiscordX(){
# Define os caminhos
origem="/usr/share/applications/discord.desktop"
destino_dir="$HOME/.local/share/applications/jrs"
destino_arquivo="$destino_dir/jrs-discordX.desktop"

# Verifica se o arquivo de origem existe
if [ -f "$origem" ]; then
    # Cria o diretório de destino se ele não existir
    if [ ! -d "$destino_dir" ]; then
        mkdir -p "$destino_dir"
        echo "Diretório $destino_dir criado."
    fi

    # Copia o arquivo para o destino
    cp "$origem" "$destino_arquivo"
    echo "Arquivo copiado para $destino_arquivo."
    
    # Edita o arquivo copiado
    if [ -f "$destino_arquivo" ]; then
        # 1. Muda a linha Exec
        sed -i 's|^Exec=.*|Exec=env ELECTRON_OZONE_PLATFORM_HINT= discord --no-sandbox|' "$destino_arquivo"
        
        # 2. Muda a linha Name
        sed -i 's|^Name=.*|Name=Discord X|' "$destino_arquivo"
        
        # 3. Muda a linha Comment (descrição)
        sed -i 's|^Comment=.*|Comment=Discord X (versão modificada para Hyprland)|' "$destino_arquivo"
        
        # 4. Muda a linha GenericName
        sed -i 's|^GenericName=.*|GenericName=Modificado para Hyprland|' "$destino_arquivo"

        echo "Arquivo jrs-discordX.desktop modificado com sucesso."
    else
        echo "Erro: O arquivo copiado não foi encontrado para edição."
    fi
else
    echo "O arquivo $origem não foi encontrado. O script será encerrado."
fi
}

