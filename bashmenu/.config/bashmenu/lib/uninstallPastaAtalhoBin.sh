#!/usr/bin/env sh
uninstallPastaAtalhoBin(){
    uninstallApplica="n"
    echo "Uninstall $3 [s/n]"
    read uninstallApplica
    if [ "$uninstallApplica" = "s" ]; then
        if [ $2 = '' ]; then
            echo "NAO COLOQUE UM VALOR VAZIO RISCO DE QUEBRAR O SISTEMA"
        else
            sudo rm -r $1 
            sudo rm $HOME/.local/share/applications/jrs/jrs-$2
            sudo rm /usr/bin/jrs-$3
        fi
        exit 1
    fi
    echo "..."
}

#remove .desktop, atalho no bin e pasta
#uninstallPastaAtalhoBin "$HOME/.Jhonatanrs/pasta" "nomedoarquivo.desktop" "atalho na pasta /usr/bin/"