#!/bin/bash

setup_git() {
	#https://docs.github.com/pt/get-started/getting-started-with-git/caching-your-github-credentials-in-git
	#vars
	echo "DIGITE SEU NOME:"
	read name
	echo "DIGITE SEU EMAIL:"
	read email
	echo "[Confirmation]
Name: $name
Email: $email
[1]Confirm [2]Exit" 
	read resp
	case $resp in
	1)
		sudo pacman -S git github-cli --needed
		gh auth login
		#global config
		git config --global user.name "$name"
		git config --global user.email "$email"
		#repositorie config
		#git config user.name "$name"
		#git config user.email "$email"
		#default branch
		git config --global init.defaultBranch $branch
		git branch -m $branch
		;;
	*) ;;
	esac
}
