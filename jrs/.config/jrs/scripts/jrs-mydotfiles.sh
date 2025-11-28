#!/bin/bash
cd ~/.dotfiles && git pull && git status
read -p "Deseja atualizar seu repositório de dotfiles? (y/N/diff) " confirm &&
if [[ "$confirm" == [yY] ]]; then
    git add . && git commit -m "att" && git push
elif [[ "$confirm" == "diff" ]]; then
    git diff
fi