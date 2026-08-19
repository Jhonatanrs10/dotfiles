#!/bin/bash
source $HOME/.config/jrs/jrs-scripts-git-dotfiles.sh

options="󰈮  Code\n󰊢  Git"

menu_cmd="rofi -dmenu -i -p Options"

# Show menu and get user selection
chosen=$(echo -e "$options" | $menu_cmd)

# Execute chosen action
case "$chosen" in
"󰈮  Code") exec_code_dotfiles ;;
"󰊢  Git") alacritty -e bash -c 'source "$HOME/.config/jrs/jrs-scripts-git-dotfiles.sh"; exec_git_dotfiles';;
*) exit 1 ;;
esac