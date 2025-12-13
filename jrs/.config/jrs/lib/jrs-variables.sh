#!/usr/bin/bash

#
JRS_DIR="$HOME/.dir_jrs"
DATANOW=$(date "+[%d-%m-%Y][%H-%M]")
#Boot
myBaseBootloader="grub efibootmgr os-prober"
#Kernels
myBaseKernel="base linux linux-firmware intel-ucode sof-firmware"
myBaseKernelLts="base linux-lts linux-firmware intel-ucode sof-firmware"
myBaseKernelZen="base linux-zen linux-zen-headers linux-firmware intel-ucode sof-firmware"
#Base
myBaseFileSystem="ntfs-3g exfat-utils dosfstools"
myBaseNetwork="networkmanager"
myBaseFirewall="gufw"
myBaseBluetooth="bluez bluez-tools bluez-utils"
myBaseCodecs="gst-plugins-ugly gst-plugins-good gst-plugins-base gst-plugins-bad gst-libav gstreamer"
myBaseIcons="papirus-icon-theme adwaita-icon-theme"
myBaseThemes="adwaita-cursors gnome-themes-extra adw-gtk-theme"
myBaseFonts="gnu-free-fonts ttf-liberation noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-ubuntu-nerd ttf-cascadia-mono-nerd ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono"
myBaseRar="bzip2 cpio gzip lha xz lzop p7zip tar unace unrar zip unzip"
myBaseNotify="libnotify dunst"
myBaseDaemons="notification-daemon power-profiles-daemon openssh syncthing"
myBaseFlatpak="flatpak"
myBaseShell="bash bash-completion shfmt"
myBaseUtilitys="nano neovim brightnessctl fastfetch yt-dlp stow curl tree jq imagemagick cmatrix btop ranger xsel pacman-contrib base-devel git ffmpeg fwupd samba udisks2 gvfs gvfs-mtp gvfs-smb gvfs-afc polkit net-tools joyutils man-db wireless_tools"
#Graphical Servers
myBaseXorg="xorg xorg-xsetroot xorg-xhost xorg-server xorg-xinit"
myBaseWayland="wayland egl-wayland"
#Audio
myBaseAudioPipeware="pipewire lib32-pipewire pipewire-alsa pipewire-audio pipewire-jack pipewire-pulse"
myBaseAudioPulse="pulseaudio pulseaudio-alsa pulseaudio-jack pulseaudio-bluetooth"
#Graphics Drivers
myBaseNvidiaExtras="nvidia-settings nvidia-utils lib32-nvidia-utils libva-nvidia-driver cuda opencl-nvidia lib32-opencl-nvidia vdpauinfo clinfo"
myBaseNvidia="nvidia"
myBaseNvidiaDkms="dkms nvidia-dkms"
myBaseIntelOld="xf86-video-intel vulkan-intel libva-intel-driver libvdpau-va-gl"
myBaseIntel="vulkan-intel libva-intel-driver libvdpau-va-gl"
myBaseAmdOld="xf86-video-ati"
myBaseAmd="mesa vulkan-radeon libva-mesa-driver libvdpau-va-gl lib32-mesa lib32-vulkan-radeon lib32-libva-mesa-driver mesa-utils"
#Window Managers and Desktop Environments
myBaseXfce4="xfce4 xfce4-goodies xfce4-docklike-plugin lightdm-gtk-greeter lightdm-gtk-greeter-settings lightdm"
myBaseKde="dolphin dolphin-plugins dragon elisa filelight gwenview okular kcalc konsole plasma-desktop sddm"
myBaseGnome="gnome gnome-tweaks gdm"
myBaseHyprland="hyprland rofi waybar hyprlock hyprpaper hypridle hyprpicker wl-clipboard xdg-desktop-portal-hyprland grim slurp polkit-gnome feh nwg-look nwg-displays lxappearance font-manager galculator system-config-printer cmus gnome-keyring baobab seahorse network-manager-applet wiremix blueman ly"
myBaseBspwm="bspwm sxhkd polybar rofi picom scrot xcolor arandr i3lock polkit-gnome feh nwg-look lxappearance font-manager galculator system-config-printer cmus gnome-keyring seahorse network-manager-applet wiremix blueman ly"
myBaseI3wm="i3 xss-lock i3status polybar rofi dmenu picom scrot xcolor arandr i3lock polkit-gnome feh nwg-look lxappearance font-manager galculator system-config-printer cmus gnome-keyring seahorse network-manager-applet wiremix blueman ly"
#Window Manager Applications
wmBaseFileManager="thunar thunar-archive-plugin tumbler ark"
wmBaseTerminal="alacritty"
wmBasePdfApp="xreader"
#Global Applications
myBaseBrowser="firefox chromium"
myBaseAudioApp="amberol"
myBaseVideoApp="mpv"
myBaseGraphicDesignApp="gimp inkscape"
myBaseSecurityApp="bitwarden"
myBaseDiskManagerApp="gparted"
myBaseOfficeApp="libreoffice-fresh"
myBaseVideoEditorApp="shotcut"
myBaseCodingApp="code l3afpad"
myBaseTorrentApp="qbittorrent"
myBaseDiscordApp="discord"
myBaseConnectApp="kdeconnect"
#Gaming
myBaseSteam="steam"
myBaseMangoHud="mangohud lib32-mangohud"
myBaseGamescope="gamescope lib32-gamemode gamemode"
myBaseRetroarch="retroarch retroarch-assets-xmb retroarch-assets-ozone libretro-snes9x libretro-mgba libretro-beetle-psx"
#Virtualization
myBaseVirt="qemu libvirt ebtables dnsmasq bridge-utils openbsd-netcat virt-manager"
#Recording
myBaseOBS="app/com.obsproject.Studio/x86_64/stable runtime/com.obsproject.Studio.Plugin.MoveTransition/x86_64/stable"
