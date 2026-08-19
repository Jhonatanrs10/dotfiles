#!/bin/bash
source $HOME/.dotfiles/jrs/.config/jrs/jrs-scripts-packages.sh

some_apps() {
	echo "Apps to install (pacman/aur/flatpak)
[1] Steam
[2] Minecraft (yay)
[3] Heroic Epic Games (yay)
[4] MangoHud
[5] Gamescope
[6] Retroarch
[7] Virtual Machine 
[8] OBS
[9] OBS (flatpak)
[10] Stream Overlay (flatpak)
[11] Discord (flatpak)
[12] Discord"

	read -r -p "Digite os números desejados (separados por espaço, ex: 1 2 9): " escolhas

	# Arrays para cada tipo de gerenciador
	local pacman_pkgs=()
	local aur_pkgs=()
	local flatpak_pkgs=()

	for resp in $escolhas; do
		case $resp in
		1) pacman_pkgs+=($myBaseSteam) ;;
		2) aur_pkgs+=($myBaseMinecraft) ;;
		3) aur_pkgs+=($myBaseHeroic) ;;
		4) pacman_pkgs+=($myBaseMangoHud) ;;
		5) pacman_pkgs+=($myBaseGamescope) ;;
		6) pacman_pkgs+=($myBaseRetroarch) ;;
		7)
			source $HOME/.dotfiles/jrs/.config/jrs/jrs-scripts-install-virt-manager.sh
			install_virt_manager
			;;
		8) pacman_pkgs+=($myBaseOBS) ;;
		9) flatpak_pkgs+=($myBaseOBSflatpak) ;;
		10) flatpak_pkgs+=($myBaseStreamOverlayflatpak) ;;
		11) flatpak_pkgs+=($myBaseDiscordAppflatpak) ;;
		12) pacman_pkgs+=($myBaseDiscordApp) ;;
		*) echo "Opção $resp é inválida, ignorando..." ;;
		esac
	done

	# 1. Instalação oficial do Pacman (Requer sudo)
	if [ ${#pacman_pkgs[@]} -gt 0 ]; then
		echo -e "\n[Pacman] Instalando: ${pacman_pkgs[*]}"
		sudo pacman -S --needed "${pacman_pkgs[@]}"
	fi

	# 2. Instalação do AUR via Yay (NÃO usa sudo)
	if [ ${#aur_pkgs[@]} -gt 0 ]; then
		echo -e "\n[AUR / yay] Instalando: ${aur_pkgs[*]}"
		yay -S --needed "${aur_pkgs[@]}"
	fi

	# 3. Instalação via Flatpak
	if [ ${#flatpak_pkgs[@]} -gt 0 ]; then
		echo -e "\n[Flatpak] Instalando: ${flatpak_pkgs[*]}"
		flatpak install "${flatpak_pkgs[@]}"
	fi
}
