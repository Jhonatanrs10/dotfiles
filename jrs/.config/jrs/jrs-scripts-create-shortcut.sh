#!/bin/bash

create_shortcut_bin() {
	varCreateShortcutBin="n"
	echo "Criar AtalhoBin? ($2) [s/n]"
	read varCreateShortcutBin
	if [ "$varCreateShortcutBin" = "s" ]; then
		chmod +x $1
		chmod 777 $1
		sudo ln -s $1 /usr/bin/jrs-$2
	fi
}

create_shortcut_desktop() {
	mkdir -p $HOME/.local/share/applications/jrs
	echo -e "[Desktop Entry]
Version=1.0
Type=Application
Name=$1
GenericName=jrs
Categories=jrs;
Comment=$2
Exec=$3
Icon=$7
Path=$4
StartupNotify=true
Terminal=$5" >$HOME/.local/share/applications/jrs/jrs-$6.desktop
}

create_shortcut_desktop_steps() {
	echo "DIGITE O NOME DO ATALHO (tudo junto sem caracteres)"
	read atalhoName
	echo "DIGITE A DESCRICAO"
	read atalhoDescricao
	echo "DIGITE O DIRETORIO DO ARQUIVO"
	read atalhoDiretorio
	echo "DIGITE O COMANDO"
	read atalhoComando
	echo "DIGITE O DIRETORIO DO ICONE"
	read atalhoIcone
	echo "TERMINAL true OU false"
	read atalhoTerminalTrueOuFalse
	create_shortcut_desktop "$atalhoName" "$atalhoDescricao" "$atalhoComando" "$atalhoDiretorio" "$atalhoTerminalTrueOuFalse" "$atalhoName" "$atalhoIcone"
}

create_shortcut_desktop_retroarch() {
	source $HOME/.dotfiles/jrs/.config/jrs/jrs-scripts-others.sh
	remove_shortcut_desktop "Retroarch"
	RetroArchCores="/usr/lib/libretro"
	RetroArchDiretorioGames="$HOME/Documents/Roms"
	echo "Colar Diretorio das Roms:"
	read RetroArchDiretorioGames
	echo "ESCOLHA A BIOS/CORE PRA A ROM:"
	options_list "$RetroArchCores" "RetroArchCore"
	options_list "$RetroArchDiretorioGames" "RetroArchGameName"
	create_shortcut_desktop "${RetroArchGameName%.*}" "Retroarch Game" "retroarch -f -L $RetroArchCores/$RetroArchCore $RetroArchDiretorioGames/$RetroArchGameName" "" "false" "Retroarch-${RetroArchGameName%.*}" "retroarch"
}

remove_shortcut_desktop() {
	echo "DESEJA APAGAR OS ATALHOS $1 (s/n)"
	read resp
	if [ "$resp" = "s" ]; then
		sudo rm $HOME/.local/share/applications/jrs/jrs-$1-*
	fi
	clear
}

create_shortcut_menu() {
	echo "[Create Shortcut Menu]
[1] Desktop
[2] Retroarch"
	read resp
	case $resp in
	1) create_shortcut_desktop_steps ;;
	2) create_shortcut_desktop_retroarch ;;
	*) ;;
	esac
}
