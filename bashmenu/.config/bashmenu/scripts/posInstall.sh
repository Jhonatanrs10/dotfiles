#!/usr/bin/bash

myBasePosInstall(){
    pacmanSetup
    yaySetup

    echo "KERNEL
[1]Linux [2]Linux-lts [3]Linux-zen"
    read resp
	case $resp in
        1)packagesManager "$myBaseKernel";;
        2)packagesManager "$myBaseKernelLts";;
        3)packagesManager "$myBaseKernelZen";;
        *)
    esac

    echo "DRIVER
[1]Configure [2]No"
    read resp
	case $resp in
        1)installVideoDriver;;
        *)
    esac

    echo "AUDIO
[1]Pipeware [2]PulseAudio"
    read resp
	case $resp in
        1)packagesManager "$myBaseAudioPipeware";;
        2)packagesManager "$myBaseAudioPulse";;
        *)
    esac

    echo "BASE
[1]Configure [2]No"
    read resp
	case $resp in
        1)packagesManager "$myBaseBootloader $myBaseFileSystem $myBaseNetwork $myBaseFirewall $myBaseUtilitys $myBaseBluetooth $myBaseCodecs $myBaseXorg $myBaseWayland $myBaseIcons $myBaseThemes $myBaseFonts $myBaseRar $myBaseNotify $myBaseDaemons $myBaseFlatpak $myBaseShell";;
        *)
    esac

    echo "APPS
[1]Configure [2]No"
    read resp
	case $resp in
        1)packagesManager "$myBaseGlobalApps";;
        *)
    esac

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
            ;;
        *)
    esac

    enableSystemctl "bluetooth"
    enableSystemctl "NetworkManager"
    enableSystemctl "power-profiles-daemon"
    enableSystemctl "sshd"

    sambaSetup

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