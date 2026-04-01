#!/bin/bash
setup_file_bashrc() {
	local BASHRC="$HOME/.bashrc"

	# Se o arquivo existe, cria um backup com timestamp
	if [[ -f "$BASHRC" ]]; then
		cp "$BASHRC" "${BASHRC}.bak.$(date +%Y%m%d_%H%M%S)"
		echo "Backup de $BASHRC criado."
	fi
	echo "#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ "'$-'" != *i* ]] && return

[[ -f ~/.config/jrs/jrs-bash-alias.sh ]] && . ~/.config/jrs/jrs-bash-alias.sh" >$HOME/.bashrc
}

setup_file_bash_profile() {
	local BASHPROFILE="$HOME/.bash_profile"

	# Se o arquivo existe, cria um backup com timestamp
	if [[ -f "$BASHPROFILE" ]]; then
		cp "$BASHPROFILE" "${BASHPROFILE}.bak.$(date +%Y%m%d_%H%M%S)"
		echo "Backup de $BASHPROFILE criado."
	fi
	echo '#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -f ~/.config/jrs/jrs-bash-exports.sh ]] && . ~/.config/jrs/jrs-bash-exports.sh' >$BASHPROFILE
}

setup_file_profile() {
	local DOTPROFILE="$HOME/.profile"

	# Se o arquivo existe, cria um backup com timestamp
	if [[ -f "$DOTPROFILE" ]]; then
		cp "$DOTPROFILE" "${DOTPROFILE}.bak.$(date +%Y%m%d_%H%M%S)"
		echo "Backup de $DOTPROFILE criado."
	fi
	echo 'setxkbmap -model abnt2 -layout br
echo "Xcursor.theme: Adwaita
Xcursor.size: 24" | xrdb -merge' >$DOTPROFILE
}

setup_file_bashrc
setup_file_bash_profile
setup_file_profile
