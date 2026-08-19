#!/bin/bash

tui_git_dotfiles() {
	source $HOME/.config/jrs/jrs-scripts-git-dotfiles.sh
	clear
	echo "[1]Code Dotfiles
[2]Git Dotfiles"
	read DOT_VAR
	case "$DOT_VAR" in
	1) exec_code_dotfiles ;;
	2) exec_git_dotfiles ;;
	*) ;;
	esac
}
