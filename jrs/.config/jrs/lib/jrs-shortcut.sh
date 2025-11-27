#!/usr/bin/env sh
criaAtalhoBin(){
    varCriaAtalhoBin="n"
    echo "Criar AtalhoBin? ($2) [s/n]"
    read varCriaAtalhoBin
    if [ "$varCriaAtalhoBin" = "s" ]; then
        chmod +x $1
        chmod 777 $1
	    sudo ln -s $1 /usr/bin/jrs-$2  
    fi
}

criaAtalhoDiretorio(){
    varcriaAtalhoDiretorio="n"
    echo "Criar AtalhoDiretorio? ($2) [s/n]"
    read varcriaAtalhoDiretorio
    if [ "$varcriaAtalhoDiretorio" = "s" ]; then
        echo "Diretorio:"
        read dp
        echo "Diretorio/atalho:"
        read da
	    ln -s $dp $da  
    fi
}

AtalhoBinExec(){
    sudo rm /usr/bin/jrs
    chmod +x $1
    chmod 777 $1
    sudo ln -s $1 /usr/bin/jrs
}
# cria atalho no bin possibilitando o uso do script em qualquer diretorio
#criaAtalhoBin "$diretorio/nome.txt" "nome do atalho para pasta /usr/bin/"
#AtalhoBinExec "diretorio/nome.txt"

criaAtalho(){
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
Terminal=$5" > $HOME/.local/share/applications/jrs/jrs-$6.desktop
}

criaAtalhoDesktop(){
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
    criaAtalho "$atalhoName" "$atalhoDescricao" "$atalhoComando" "$atalhoDiretorio" "$atalhoTerminalTrueOuFalse" "$atalhoName" "$atalhoIcone"
}

criaAtalhoDesktopRetroarchArch(){
    removeAllDesktop "Retroarch"
    RetroArchCores="/usr/lib/libretro"
    RetroArchDiretorioGames="$HOME/Documents/Roms"
    echoRead "Colar Diretorio das Roms:" "RetroArchDiretorioGames"
    echo "ESCOLHA A BIOS/CORE PRA A ROM:"
    listaOptions "$RetroArchCores" "RetroArchCore"
    listaOptions "$RetroArchDiretorioGames" "RetroArchGameName"
    criaAtalho "${RetroArchGameName%.*}" "Retroarch Game" "retroarch -f -L $RetroArchCores/$RetroArchCore $RetroArchDiretorioGames/$RetroArchGameName" "" "false" "Retroarch-${RetroArchGameName%.*}" "retroarch"
}

removeAllDesktop(){
    echoRead "DESEJA APAGAR OS ATALHOS $1 (s/n)" "resp"
    if [ "$resp" = "s" ]; then
        sudo rm $HOME/.local/share/applications/jrs/jrs-$1-*
    fi
    clear
}

removeDesktopJRS(){
    listaOptions "$HOME/.local/share/applications" "ptDesktop" "-d jrs-*"
    echoRead "DESEJA APAGAR O ATALHO $ptDesktop (s/n)" "resp"
    if [ "$resp" = "s" ]; then
        sudo rm $HOME/.local/share/applications/jrs/$ptDesktop
    fi
}

#removeAllDesktop "palavrachave ex retroarch"

criaAtalhoDesktopAppimage(){
    removeAllDesktop "Appimage"
    echoRead "COLE O DIRETORIO DOS APPIMAGES: " "appimageFolder"
    mkdir -p $appimageFolder
    for vApp in `ls $appimageFolder`
        do
            chmod 777 $appimageFolder/$vApp
            criaAtalho "${vApp%.*}" "An Appimage" "./$vApp" "$appimageFolder" "false" "Appimage-${vApp%.*}" "application-default-icon"
        done


}

setupAppimage(){
    sudo rm $HOME/.local/share/applications/jrs/jrs-Appimage-*
    echo "Criando diretorio AppImages"
    sleep 2
    mkdir -p $JRS_DIR/AppImages
    for vApp in `ls $JRS_DIR/AppImages`
    do
        chmod 777 $JRS_DIR/AppImages/$vApp
        criaAtalho "${vApp%.*}" "An Appimage" "./$vApp" "$JRS_DIR/AppImages" "false" "Appimage-${vApp%.*}" "application-default-icon"
    done
}

#remove quebra de linha (arquivos SVG)
#https://miniwebtool.com/br/remove-line-breaks/
# cria um atalho .desktop
#criaAtalho "nomedoatalho" "comentario" "execucao" "$diretorioInstall" "terminaltrueoufalse" "nomedoarquivo" '$HOME/.Jhonatanrs/Icons/nome.svg'

AtalhoTerminalBin(){
    varAtalhoTerminalBin="vazio"
    clear
    while [ "$varAtalhoTerminalBin" != "" ];
    do
        echo "ESCOLHA UMA DAS OPCOES:  [1]CriaAtalhoTBin, [2]removeAtalhoTBin"
        read resp
        if [ "$resp" = "1" ]; then
            criaAtalhoTerminalBin
        elif [ "$resp" = "2" ]; then
            removeAtalhoBinJrs
        else
            echo "NENHUMA OPCAO FOI ESCOLHIDA."
            exit 1
        fi
        clear
    done
}

criaAtalhoTerminalBin(){
    criaDiretorioInstall "$JRS_DIR/Bins"   
    echo "DIGITE OU COLE O COMANDO DE TERMINAL:"
    read comandoTerminal
    echo "DIGITE OU COLE O NOME DO ATALHO/ARQUIVO BIN:"
    read atalhoBin
        criarArq "#!/usr/bin/env sh
$comandoTerminal" "$atalhoBin.sh"
    criaAtalhoBin "$diretorioInstall/$atalhoBin.sh" "$atalhoBin"
}

criaAtalhoFlatpakBin(){
    diretorioFlatpak="/var/lib/flatpak/exports/bin/"
    for flatpak in `ls $diretorioFlatpak`
    do
        criaAtalhoBin "$diretorioFlatpak$flatpak" "$flatpak"
    done
}

removeAtalhoBinJrs(){
    cd /usr/bin
    echo "[Bins]"
    ls jrs-*
    echo "DIGITE O NOME DO ATALHO/ARQUIVO BIN QUE DESEJA REMOVER: (SEM O 'jrs-')"
    read atalhoBin
    removeAtalhoBin "$atalhoBin"
    rm $JRS_DIR/Bins/$atalhoBin.sh
    cd $HOME
}

removeAtalhoBin(){
    if [ $1 = '' ]; then
        echo "NAO COLOQUE UM VALOR VAZIO RISCO DE QUEBRAR O SISTEMA"
    else
        sudo rm /usr/bin/jrs-$1
    fi
}
#removeAtalhoBin "nome do atalho na pasta /usr/bin/ sempre deixar esse campo preenchido pra nao apagar a pasta bin"

criaArqRunDiretorioInstall(){
    criaDiretorio "shortcuts" "$JRS_DIR/Shortcuts"
    echo -e 'DIGITE O DIRETORIO OU DIRETORIO/ARQUIVO.EXTENSION Ex:/home/user/Downloads Ou /home/user/teste.txt'
    read nesseDir
    echo 'DIGITE UM NOME PARA O ATALHO'
    read nomeDir
    criaLinkSym "$nesseDir" "$shortcuts/$nomeDir"
} 

uninstallPastaAtalhoBinMesmoNome(){
    uninstallPastaAtalhoBin "$JRS_DIR/$1" "$1.desktop" "$1" 
}
#uninstallPastaAtalhoBinMesmoNome "Nome igual em Pasta, Atalho e Bin"

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