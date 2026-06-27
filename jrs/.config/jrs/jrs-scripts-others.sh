#!/bin/bash

sourceFolder() {
	for src in $(ls $1); do
		source $1/$src
		#echo "$1/$src"
	done
	#sleep 10
}

forLength() {
	echo $1
	read txtForLength
	if [ "$txtForLength" = "" ]; then
		txtForLength=$3
		echo "Valor vazio, Default $txtForLength"
	elif [ "$(expr length $txtForLength)" = $2 ]; then
		echo "Escolha $txtForLength"
	else
		txtForLength=$3
		echo "Necessario 6 digitos, Default $txtForLength"
	fi
}
#forLength "Titulo" "numero/tamanho/length" "default value"

options_list() {
	zOptionsList="/tmp/zOptionsList.txt"
	cd $1
	ls $3 . >$zOptionsList
	cd $OLDPWD
	echo "[Options List] DIGITE O NUMERO DA SUA ESCOLHA:"
	cat -n $zOptionsList
	echo "[Options List]"
	read zOptionL
	#pega conteudo do arquivo | numera o conteudo por linha | escolhe uma linha | elimina o numero da linha e deixa so o conteudo
	export $2=$(cat $zOptionsList | grep -n ^ | grep ^$zOptionL | cut -d: -f2)
}

rofi_or_wofi() {
	# Detect session type and choose appropriate menu
	if [ "$XDG_SESSION_TYPE" = "x11" ] && command -v rofi &>/dev/null; then
		menu_cmd="rofi -dmenu -i -p Profiles"
	elif [ "$XDG_SESSION_TYPE" = "wayland" ] && command -v wofi &>/dev/null; then
		menu_cmd="wofi --dmenu --prompt=Options"
	else
		echo "ERROR: No suitable menu found" >&2
		exit 1
	fi
}
