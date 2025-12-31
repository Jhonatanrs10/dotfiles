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

listaOptions() {
	zListaOptions="/tmp/zListaOptions.txt"
	cd $1
	ls $3 . >$zListaOptions
	cd $OLDPWD
	echo "[ListaOptions] DIGITE O NUMERO DA SUA ESCOLHA:"
	cat -n $zListaOptions
	echo "[ListaOptions]"
	read zLOption
	#pega conteudo do arquivo | numera o conteudo por linha | escolhe uma linha | elimina o numero da linha e deixa so o conteudo
	export $2=$(cat $zListaOptions | grep -n ^ | grep ^$zLOption | cut -d: -f2)
}

echoRead() {
	echo $1
	read $2
}
#echoRead "MSG" "VAR RETORNO"
#listaOptions "/home/user/diretorio" "nome-variavel-retorno" "criterio do ls ex ls jrs-*"

setLink() {
	varLink="$1"
}

yesorno() {
	echo -e "$1 [s/n]"
	read resp
	if [ "$resp" = "s" ]; then
		$2
	fi
}
#yesorno "Titulo" "Script"

baixaDebs() {
	criaDiretorio "diretorioBaixaDebs" "$JRS_DIR/tempArqs"
	clear
	echo -e "Deseja baixar $1? [s/n]"
	read resp
	if [ "$resp" = s ]; then
		baixaArq "diretorioNome" "$2" "$diretorioBaixaDebs/$1.deb"
	fi
}
#baixaDebs "Nomedoapp" "linkdodeb"

baixaArq() {
	if [ $1 = 'diretorio' ]; then
		wget -c -P "$3" "$2"
	elif [ $1 = 'diretorioNome' ]; then
		wget -c "$2" -O "$3"
	fi
}
#baixaArq "diretorioNome Ou diretorio" "links" "diretorio/Nome.tar"

rofi-or-wofi() {
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

myBaseMountDisk() {

	my_disk_dir="/media/"
	# somente leitura pode ser o modo de energia do windows em dualboot (modo de reinicialização rapida)
	echo "Mount Disk?
Options: [1]Yes, [2]No"
	read resp
	case $resp in
	1)
		sudo fdisk -l
		echo "Digite o caminho do disco Ex.: /dev/sdb1"
		read DEVSD
		sudo cp /etc/fstab /etc/fstab$DATANOW.bkp
		sudo mkdir -p $my_disk_dir$(sudo blkid -s UUID -o value $DEVSD)
		#id -u
		#id -g
		echo "Type Disk
Options: [1]ext4 [2]ntfs"
		read resp
		case $resp in
		1)
			sudo tee -a /etc/fstab <<<'# '$DEVSD' 
UUID='$(sudo blkid -s UUID -o value $DEVSD)' '$my_disk_dir$(sudo blkid -s UUID -o value $DEVSD)' ext4 rw,exec,nosuid,nodev,nofail,x-gvfs-show 0 0'
			sudo chown -R $USER:$USER $my_disk_dir$(sudo blkid -s UUID -o value $DEVSD)
			;;
		2)
			sudo tee -a /etc/fstab <<<'# '$DEVSD' 
UUID='$(sudo blkid -s UUID -o value $DEVSD)' '$my_disk_dir$(sudo blkid -s UUID -o value $DEVSD)' ntfs uid='$(id -u)',gid='$(id -g)',rw,user,exec,nofail,umask=000 0 0'
			;;
		*) ;;
		esac
		cat /etc/fstab
		sleep 5

		#rm -r ~/.steam/steam/steamapps/compatdata
		#mkdir -p ~/.steam/steam/steamapps/compatdata
		#ln -s ~/.steam/steam/steamapps/compatdata /media/gamedisk/Steam/steamapps/
		;;
	*) ;;
	esac
}

myBaselnHome() {
	echo "Gerar Link Simbólico na Home?
Options: [1]Yes, [2]No"
	read resp
	case $resp in
	1)
		echo "Digite o diretório que deseja um link (/media/Downloads)"
		read resp
		ln -s $resp $HOME
		;;
	*) ;;
	esac

}

criaAtalhoBin() {
	varCriaAtalhoBin="n"
	echo "Criar AtalhoBin? ($2) [s/n]"
	read varCriaAtalhoBin
	if [ "$varCriaAtalhoBin" = "s" ]; then
		chmod +x $1
		chmod 777 $1
		sudo ln -s $1 /usr/bin/jrs-$2
	fi
}

criaAtalho() {
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
Terminal=$5" >$HOME/.local/share/applications/jrs/jrs-$6.desktop
}

criaAtalhoDesktop() {
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

criaAtalhoDesktopRetroarchArch() {
	removeAllDesktop "Retroarch"
	RetroArchCores="/usr/lib/libretro"
	RetroArchDiretorioGames="$HOME/Documents/Roms"
	echoRead "Colar Diretorio das Roms:" "RetroArchDiretorioGames"
	echo "ESCOLHA A BIOS/CORE PRA A ROM:"
	listaOptions "$RetroArchCores" "RetroArchCore"
	listaOptions "$RetroArchDiretorioGames" "RetroArchGameName"
	criaAtalho "${RetroArchGameName%.*}" "Retroarch Game" "retroarch -f -L $RetroArchCores/$RetroArchCore $RetroArchDiretorioGames/$RetroArchGameName" "" "false" "Retroarch-${RetroArchGameName%.*}" "retroarch"
}

removeAllDesktop() {
	echoRead "DESEJA APAGAR OS ATALHOS $1 (s/n)" "resp"
	if [ "$resp" = "s" ]; then
		sudo rm $HOME/.local/share/applications/jrs/jrs-$1-*
	fi
	clear
}

removeDesktopJRS() {
	listaOptions "$HOME/.local/share/applications" "ptDesktop" "-d jrs-*"
	echoRead "DESEJA APAGAR O ATALHO $ptDesktop (s/n)" "resp"
	if [ "$resp" = "s" ]; then
		sudo rm $HOME/.local/share/applications/jrs/$ptDesktop
	fi
}

#removeAllDesktop "palavrachave ex retroarch"

criaAtalhoDesktopAppimage() {
	removeAllDesktop "Appimage"
	echoRead "COLE O DIRETORIO DOS APPIMAGES: " "appimageFolder"
	mkdir -p $appimageFolder
	for vApp in $(ls $appimageFolder); do
		chmod 777 $appimageFolder/$vApp
		criaAtalho "${vApp%.*}" "An Appimage" "./$vApp" "$appimageFolder" "false" "Appimage-${vApp%.*}" "application-default-icon"
	done

}

setupAppimage() {
	sudo rm $HOME/.local/share/applications/jrs/jrs-Appimage-*
	echo "Criando diretorio AppImages"
	sleep 2
	mkdir -p $JRS_DIR/AppImages
	for vApp in $(ls $JRS_DIR/AppImages); do
		chmod 777 $JRS_DIR/AppImages/$vApp
		criaAtalho "${vApp%.*}" "An Appimage" "./$vApp" "$JRS_DIR/AppImages" "false" "Appimage-${vApp%.*}" "application-default-icon"
	done
}

#remove quebra de linha (arquivos SVG)
#https://miniwebtool.com/br/remove-line-breaks/
# cria um atalho .desktop
#criaAtalho "nomedoatalho" "comentario" "execucao" "$diretorioInstall" "terminaltrueoufalse" "nomedoarquivo" '$HOME/.Jhonatanrs/Icons/nome.svg'

AtalhoTerminalBin() {
	varAtalhoTerminalBin="vazio"
	clear
	while [ "$varAtalhoTerminalBin" != "" ]; do
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

criaAtalhoTerminalBin() {
	criaDiretorioInstall "$JRS_DIR/Bins"
	echo "DIGITE OU COLE O COMANDO DE TERMINAL:"
	read comandoTerminal
	echo "DIGITE OU COLE O NOME DO ATALHO/ARQUIVO BIN:"
	read atalhoBin
	criarArq "#!/bin/bash
$comandoTerminal" "$atalhoBin.sh"
	criaAtalhoBin "$diretorioInstall/$atalhoBin.sh" "$atalhoBin"
}

criaAtalhoFlatpakBin() {
	diretorioFlatpak="/var/lib/flatpak/exports/bin/"
	for flatpak in $(ls $diretorioFlatpak); do
		criaAtalhoBin "$diretorioFlatpak$flatpak" "$flatpak"
	done
}

removeAtalhoBinJrs() {
	cd /usr/bin
	echo "[Bins]"
	ls jrs-*
	echo "DIGITE O NOME DO ATALHO/ARQUIVO BIN QUE DESEJA REMOVER: (SEM O 'jrs-')"
	read atalhoBin
	removeAtalhoBin "$atalhoBin"
	rm $JRS_DIR/Bins/$atalhoBin.sh
	cd $HOME
}

removeAtalhoBin() {
	if [ $1 = '' ]; then
		echo "NAO COLOQUE UM VALOR VAZIO RISCO DE QUEBRAR O SISTEMA"
	else
		sudo rm /usr/bin/jrs-$1
	fi
}
#removeAtalhoBin "nome do atalho na pasta /usr/bin/ sempre deixar esse campo preenchido pra nao apagar a pasta bin"

criaArqRunDiretorioInstall() {
	criaDiretorio "shortcuts" "$JRS_DIR/Shortcuts"
	echo -e 'DIGITE O DIRETORIO OU DIRETORIO/ARQUIVO.EXTENSION Ex:/home/user/Downloads Ou /home/user/teste.txt'
	read nesseDir
	echo 'DIGITE UM NOME PARA O ATALHO'
	read nomeDir
	criaLinkSym "$nesseDir" "$shortcuts/$nomeDir"
}

uninstallPastaAtalhoBinMesmoNome() {
	uninstallPastaAtalhoBin "$JRS_DIR/$1" "$1.desktop" "$1"
}
#uninstallPastaAtalhoBinMesmoNome "Nome igual em Pasta, Atalho e Bin"

uninstallPastaAtalhoBin() {
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
