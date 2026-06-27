#!/bin/bash

install_virt_manager() {
	source $HOME/.dotfiles/jrs/.config/jrs/jrs-scripts-packages.sh
	sudo pacman -S $myBaseVirt --needed
	sudo systemctl enable "libvirtd" --now
	sudo virsh net-autostart default
	#sudo virsh net-start default
}