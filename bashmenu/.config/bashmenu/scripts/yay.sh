#!/usr/bin/env sh
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
