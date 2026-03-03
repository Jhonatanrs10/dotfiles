#!/bin/bash
sudo pacman -S --needed stow git
git clone https://github.com/Jhonatanrs10/dotfiles ~/.dotfiles
cd ~/.dotfiles
stow */