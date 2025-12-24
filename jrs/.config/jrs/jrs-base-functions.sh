#!/bin/bash

######
source jrs-variables.sh
######

TEMPLATE(){

    installName="SCRIPTMODELO"
    uninstallPastaAtalhoBinMesmoNome "$installName"
    criaDiretorioInstall "$JRS_DIR/$installName"

    #criaPastaBaixaExtrai "$diretorioInstall" "Link" "mod.jar"

    #entra em pasta * pega arquivos * e move uma pasta atras .  
    #mv */* .

    #criaArqRunDiretorioInstall "#!/bin/bash
#cd $diretorioInstall
#./nomearquivo"

    criaAtalho "$installName" "Description" "bash run.sh" "$diretorioInstall" "false" "$installName" "application-default-icon"
    criaAtalhoBin "$diretorioInstall/run.sh" "$installName"

} 

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


criaDiretorioInstall() {
	export diretorioInstall="$1"
	mkdir -p $diretorioInstall
	cd $diretorioInstall
}

criaDiretorio() {
	export $1="$2"
	mkdir -p $2
}
#criaDiretorioInstall "$HOME/.diretorio"
#criaDiretorio "nomedavariavel" "$HOME/.diretorio"

criaLinkSym() {
	ln -s $1 $2
}
#criaLinkSym "diretorio" "diretorioLinkSym"

criaPastaBaixaExtrai() {
	criaDiretorio "bac" "$1"
	baixaArq "diretorioNome" "$2" "$1/$3"
	extrairArq "$bac"
}
#criaPastaBaixaExtrai "$HOME/.diretorio" "Link" "mod.jar"

criarArq() {
	echo "$1" >$2
}
nomeDoArquivo() {
	cd $1
	return $(ls *$2*)
}
addNoArq() {
	echo "$1" >>$2
}

criarArqv2() {
	cat <<REALEND >$2
$1
REALEND
}
#nomeDoArquivo "diretorio" "caracter que possui ex .jar"
#criarArq "seu texto aqui" "nomedoarquivo.txt"
#addNoArq "seu texto aqui" "nomedoarquivo.txt"
#criarArqv2 "seu texto aqui" "diretorio/nomedoarquivo.txt"

addArchi386() {
	echo -e '[INFO] - ADCIONANDO ARQUITETURA DE 32 BITS - [INFO]'
	sudo dpkg --add-architecture i386
}

aptUpdate() {
	echo -e "[INFO] - ATUALIZANDO REPOSITORIO E FAZENDO ATUALIZACAO DO SISTEMA - [INFO]"
	sudo apt update && sudo apt dist-upgrade -y
}

installDebs() {
	echo -e "[INFO] - INSTALANDO PACOTES DEB - [INFO]"
	sudo dpkg -i $1/*.deb
}

justAptUpdate() {
	echo -e "[INFO] - ATUALIZANDO O REPOSITORIO - [INFO]"
	sudo apt update -y
}

supFlatpakApt() {
	sudo add-apt-repository ppa:flatpak/stable
	sudo apt update
	sudo apt install flatpak
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

teste_internet() {
	echo -e "[INFO] - VERIFICANDO CONEXAO COM A REDE - [INFO]"
	if ! ping -c 1 8.8.8.8 -q >/dev/null 2>&1; then
		echo -e "[INFO] - SEM CONEXAO COM INTERNET - [INFO]"
		exit 1
	else
		echo -e "[INFO] - CONEXAO COM INTERNET FUNCIONANDO NORMALMENTE - [INFO]"
	fi
}

travas_apt() {
	sudo rm /var/lib/dpkg/lock-frontend
	sudo rm /var/cache/apt/archives/lock
}

installDriverNvidia() {
	aptUpdate
	ubuntu-drivers devices
	echo "Visualizar Drivers: ubuntu-drivers devices
Instalar Drivers: sudo apt install nvidia-driver-X"
}

posInstallDeb() {
	yesorno "Deseja testar conexao?" "teste_internet"
	travas_apt
	justAptUpdate
	addArchi386
	yesorno "Instalar o Flatpak?" "supFlatpak"
	echo "PACOTES:
samba gparted neofetch blueman mpv vlc git wget openjdk-8-jdk openjdk-11-jdk openjdk-17-jdk htop qbittorrent"
	read pacotes
	packagesManager "$pacotes"
	baixaDebs "Chrome" "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
	baixaDebs "vscode" "https://go.microsoft.com/fwlink/?LinkID=760868"
	baixaDebs "Discord" "https://discord.com/api/download?platform=linux&format=deb"
	baixaDebs "Steam" "https://cdn.akamai.steamstatic.com/client/installer/steam.deb"
	yesorno "Deseja instalar os .deb?" "installDebs $diretorioBaixaDebs"
	yesorno "Deseja apagar a pasta dos .deb?" "rm -r $diretorioBaixaDebs"
}

installVideoDriver() {
	echo -e "\n==== Instalação de Drivers de Vídeo no Arch Linux ====\n"

	# Loop de seleção
	while true; do
		echo "Escolha o driver que deseja instalar:"
		echo "1 - NVIDIA"
		echo "2 - NVIDIA DKMS"
		echo "3 - Intel (moderno)"
		echo "4 - Intel (antigo / xf86-video-intel )"
		echo "5 - AMD (moderno)"
		echo "6 - AMD (antigo)"
		read -rp "Digite o número da opção desejada: 
" choice

		case $choice in
		1)
			DRIVER_NAME="NVIDIA"
			DRIVER_PACKAGES="$myBaseNvidia $myBaseNvidiaExtras"
			break
			;;
		2)
			DRIVER_NAME="NVIDIA"
			DRIVER_PACKAGES="$myBaseNvidiaDkms $myBaseNvidiaExtras"
			break
			;;
		3)
			DRIVER_NAME="Intel (moderno)"
			DRIVER_PACKAGES="$myBaseIntel"
			break
			;;
		4)
			DRIVER_NAME="Intel (antigo)"
			DRIVER_PACKAGES="$myBaseIntelOld"
			break
			;;
		5)
			DRIVER_NAME="AMD (moderno)"
			DRIVER_PACKAGES="$myBaseAmd"
			break
			;;
		6)
			DRIVER_NAME="AMD (antigo)"
			DRIVER_PACKAGES="$myBaseAmdOld"
			break
			;;
		*) return ;;
		esac
	done

	echo "Você escolheu: $DRIVER_NAME"
	echo "Pacotes que serão instalados: $DRIVER_PACKAGES"

	# Atualiza o sistema e instala pacotes básicos
	sudo pacman -Syu --noconfirm
	sudo pacman -S base-devel linux-headers git nano --needed --noconfirm

	# Instala os pacotes do driver escolhido
	sudo pacman -S $DRIVER_PACKAGES --needed --noconfirm

	# Se for NVIDIA, faz configurações adicionais
	if [[ "$DRIVER_NAME" == "NVIDIA" ]]; then
		echo "Configurando GRUB para NVIDIA..."

		KERNEL_VERSION=$(uname -r | cut -d. -f1,2)

		if (($(echo "$KERNEL_VERSION >= 6.11" | bc -l))); then
			EXTRA_OPTS="nvidia-drm.modeset=1 nvidia-drm.fbdev=1"
		else
			EXTRA_OPTS="nvidia-drm.modeset=1"
		fi

		GRUB_FILE="/etc/default/grub"
		sudo cp "$GRUB_FILE" "$GRUB_FILE.bak"

		sudo sed -i "/^GRUB_CMDLINE_LINUX_DEFAULT=/ {
    s/\"$/ $EXTRA_OPTS\"/
    s/\(.*\)nvidia-drm\.modeset=1//g
    s/\(.*\)nvidia-drm\.fbdev=1//g
  }" "$GRUB_FILE"

		echo "Atualizando GRUB..."
		sudo grub-mkconfig -o /boot/grub/grub.cfg

		echo "Configurando mkinitcpio para NVIDIA..."
		sudo cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.bak
		sudo sed -i 's/^MODULES=.*/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
		sudo sed -i 's/\<kms\>//g' /etc/mkinitcpio.conf

		echo "Regenerando initramfs..."
		sudo mkinitcpio -P

		echo "Instalando hook do driver NVIDIA..."
		cd ~ || exit
		wget https://raw.githubusercontent.com/korvahannu/arch-nvidia-drivers-installation-guide/main/nvidia.hook -O nvidia.hook
		sed -i "s/^Target=nvidia$/Target=nvidia/" nvidia.hook
		sudo mkdir -p /etc/pacman.d/hooks/
		sudo mv nvidia.hook /etc/pacman.d/hooks/
	fi

	echo "✅ Instalação concluída! Reinicie o sistema para aplicar as mudanças."
}

extrairArq() {
	echo "EXTRAINDO..."
	for arq in $(ls $1); do
		if [[ $arq =~ .*.tar.gz ]]; then
			tar -vzxf $1/$arq -C $1
			rm -r $1/$arq
		fi
		if [[ $arq =~ .*.tar.bz2 ]]; then
			tar -jxvf $1/$arq -C $1
			rm -r $1/$arq
		fi
		if [[ $arq =~ .*.tar.xz ]]; then
			tar -xvf $1/$arq -C $1
			rm -r $1/$arq
		fi
		if [[ $arq =~ .*.zip ]]; then
			unzip -o $1/$arq -d $1
			rm -r $1/$arq
		fi
		if [[ $arq =~ .*.rar ]]; then
			unrar x $1/$arq -C $1
			rm -r $1/$arq
		fi
		if [[ $arq =~ .*.tar ]]; then
			tar -xvf $1/$arq -C $1
			rm -r $1/$arq
		fi
		if [[ $arq =~ .*.bz2 ]]; then
			bzip2 -d $1/$arq -C $1
			rm -r $1/$arq
		fi
		if [[ $arq =~ .*.tar.zst ]]; then
			tar xaf $1/$arq -C $1
			rm -r $1/$arq
		fi
		if [[ $arq =~ .*.tgz ]]; then
			tar -xvzf $1/$arq -C $1
			rm -r $1/$arq
		fi
	done
	echo "CONCLUIDO!!!"
}
#extrairArq "$diretorioInstall"

installPokexgames(){
    pxg="https://download.pokexgames.com/pxg-linux.zip"
    diretorioPokexgames="$JRS_DIR/Pokexgames"
    uninstallPastaAtalhoBinMesmoNome "Pokexgames"
	criaPastaBaixaExtrai "$diretorioPokexgames" "$pxg" "pxg.zip"
    criaAtalho "Pokexgames" "Tibia Pokemon" "./pxgme-linux" "$diretorioPokexgames" "false" "Pokexgames" "application-default-icon"
    criaAtalhoBin "$diretorioPokexgames/pxgme-linux" "Pokexgames"
}

installMinecraft(){
	packagesManager "jre-openjdk"
	verMine="https://tlauncher.org/jar"
	uninstallPastaAtalhoBinMesmoNome "MinecraftTlauncher"
	echo -e "[INFO] - CRIANDO DIRETORIOS... - [INFO]"
	criaDiretorio "diretorioMine" "$JRS_DIR/MinecraftTlauncher"
	echo -e "[INFO] - BAIXANDO ARQUIVOS... - [INFO]"
	baixaArq "diretorioNome" "$verMine" "$diretorioMine/tlauncher.zip"
    extrairArq "$diretorioMine"
	cd $diretorioMine
    tlauncher=`ls *.jar`
    criarArq "#!/bin/bash
	cd $diretorioMine
	java -jar $tlauncher" "$diretorioMine/tlauncher.sh"
    criaAtalho "MinecraftTlauncher" "Create your own world on Xorg" "bash tlauncher.sh" "$diretorioMine" "false" "TLauncher" "/usr/share/icons/Papirus-Dark/64x64/apps/minecraft.svg"
	criaAtalhoBin "$diretorioMine/tlauncher.sh" "TLauncher"
	echo -e "[INFO] - SCRIPT FINALIZADO - [INFO]"
}

gitconfig(){
    #https://docs.github.com/pt/get-started/getting-started-with-git/caching-your-github-credentials-in-git
    packagesManager "git gh github-cli"
    gh auth login
    #vars
    echo "DIGITE SEU NOME:"
    read name
    echo "DIGITE SEU EMAIL:"
    read email
    branch = "main"
    #global config
    git config --global user.name "$name"
    git config --global user.email "$email"
    #repositorie config
    #git config user.name "$name"
    #git config user.email "$email"
    #default branch
    git config --global init.defaultBranch $branch
    git branch -m $branch

}

gitAutoPush(){
    myGitsFolder="$HOME/Documents/GitHub"
    listaOptions "$myGitsFolder" "myGits"
    cd $myGitsFolder/$myGits
    git status
    yesorno "PULL" "git pull"
    echo "COMMIT:"
    read textCommit
    yesorno "ADD" "git add ."
    git status
    yesorno "COMMIT ($textCommit)" "git commit -m "$textCommit""
    git status
    yesorno "PUSH" "git push --verbose"
    git status
    sleep 5
}

javaVersion(){
    echo "DEBIAN BASE
sudo update-alternatives --config java

ARCH 
archlinux-java --help
    "
    read finalizado
}


installJava() {
  echo "=== Instalação de JRE no Arch Linux ==="
  echo "Escolha a versão do JRE que deseja instalar:"
  echo "1) jre-openjdk (última versão)"
  echo "2) jre8-openjdk (OpenJDK 8)"
  echo "3) jre11-openjdk (OpenJDK 11 LTS)"
  echo "4) jre17-openjdk (OpenJDK 17 LTS)"
  echo "5) Version"
  echo "6) Sair"

  while true; do
    read -rp "Digite o número da opção desejada: " choice

    case $choice in
      1)
        pkg="jre-openjdk"
        break
        ;;
      2)
        pkg="jre8-openjdk"
        break
        ;;
      3)
        pkg="jre11-openjdk"
        break
        ;;
      4)
        pkg="jre17-openjdk"
        break
        ;;
      5)javaVersion
        exit 0
        ;;
      6)
        echo "Saindo sem instalar nada."
        exit 0
        ;;
      *)
        echo "Opção inválida. Tente novamente."
        ;;
    esac
  done

  echo "Instalando pacote $pkg..."
  sudo pacman -Syu --noconfirm
  sudo pacman -S --needed --noconfirm "$pkg"
  echo "Instalação concluída!"
}

nodejslts() {
    echo "Nodejs Manual[1] ou pacman[2]"
    read escolha
    if [ "$escolha" = "1" ]; then
        installName="NodeJS"
        criaDiretorioInstall "$JRS_DIR/$installName"
        criaPastaBaixaExtrai "$diretorioInstall" "https://nodejs.org/dist/v20.9.0/node-v20.9.0-linux-x64.tar.xz" "node.tar.xz"
        sudo cp -r $diretorioInstall/* /usr/
        export PATH=/usr/node*/bin:$PATH
        rm -r $diretorioInstall
    elif [ "$escolha" = "2" ]; then
        packagesManager "nodejs-lts-iron"
        packagesManager "npm"
    fi
}

packagesManager(){
	#clear
	echo "PACKAGES
[$1]	
Options: [1]Pacman, [2]Yay, [3]pamac, [4]Flatpak, [5]Apt
to uninstall for example a Pacman Package put [0] before option. Ex: [01]"
	read resp

	case $resp in
		1)sudo pacman -S $1 --needed;;
		2)yay -S $1 --needed;;
		3)sudo pamac install $1;;
		4)flatpak install $1;;
		5)sudo apt install $1;;
		01)for pacote in $1; do sudo pacman -R --noconfirm $pacote; done ;;
		02)for pacote in $1; do yay -R --noconfirm $pacote; done ;;
		03)for pacote in $1; do sudo pamac remove --no-confirm $pacote; done ;;
		04)for pacote in $1; do flatpak remove -y $pacote; done ;;
		05)for pacote in $1; do sudo apt remove -y $pacote; done ;;
		*)
	esac
	#sleep 5
}

repairPM(){
	echo "[REPAIR PACKAGES MANAGER]
Options: [1]Apt [2]Pacman"
	read resp
	case $resp in
		1)
			sudo dpkg --configure -a
			sudo apt --fix-broken install -y
			;;
		2)
			sudo rm /var/lib/pacman/db.lck
			;;
		*)
	esac
}
#packagesManager "apt1 apt2 apt3"
#repairPM

myBasePosInstall() {
  echo "[0]Pos Install Setup
[1]Pacman
[2]Yay
[3]Grub
[4]Kernel
[5]Driver
[6]Audio
[7]Base
[8]Apps
[9]Start
[10]Samba
[11]Configs
[12]Desktop
"

  read resp
  case $resp in
  1) pacmanSetup ;;
  2) yaySetup ;;
  3) grubSetup ;;
  4) kernelSetup ;;
  5) driverSetup ;;
  6) audioSetup ;;
  7) baseSetup ;;
  8) appsSetup ;;
  9) startSetup ;;
  10) sambaSetup ;;
  11) configsSetup ;;
  12) desktopSetup ;;
  0)
    pacmanSetup
    yaySetup
    grubSetup
    kernelSetup
    driverSetup
    audioSetup
    baseSetup
    appsSetup
    startSetup
    sambaSetup
    configsSetup
    desktopSetup
    ;;
  *) ;;
  esac

}

pacmanSetup() {
  echo "PACMAN
Options: [1]Configure, [2]No"
  read resp
  case $resp in
  1)
    sudo cp /etc/pacman.conf /etc/pacman$DATANOW.conf.bkp
    sudo sed -i 's/ParallelDownloads = 5/ParallelDownloads = 10\nILoveCandy\nColor/g' /etc/pacman.conf
    sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
    sudo pacman -Syyu
    ;;
  *) ;;
  esac
}

yaySetup() {
  echo "YAY
Options: [1]Configure, [2]No"
  read resp
  case $resp in
  1)
    sudo pacman -S --needed git base-devel
    cd $HOME
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    ;;
  *) ;;
  esac
}

grubSetup() {
  echo "GRUB
Options: [1]Configure, [2]No"
  read resp
  case $resp in
  1)
    packagesManager "$myBaseBootloader"
    sudo cp /etc/default/grub /etc/default/grub$DATANOW.bkp
    sudo cp /boot/grub/grub.cfg /boot/grub/grub$DATANOW.cfg.bkp
    sudo grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
    sudo sed -i "/GRUB_DISABLE_OS_PROBER=false/"'s/^#//' /etc/default/grub
    sudo grub-mkconfig -o /boot/grub/grub.cfg
    ;;
  *) ;;
  esac
}

kernelSetup() {
  echo "KERNEL
[1]Linux [2]Linux-lts [3]Linux-zen"
  read resp
  case $resp in
  1) packagesManager "$myBaseKernel" ;;
  2) packagesManager "$myBaseKernelLts" ;;
  3) packagesManager "$myBaseKernelZen" ;;
  *) ;;
  esac
}

driverSetup() {
  echo "DRIVER
[1]Configure [2]No"
  read resp
  case $resp in
  1) installVideoDriver ;;
  *) ;;
  esac
}

audioSetup() {
  echo "AUDIO
[1]Pipeware [2]PulseAudio"
  read resp
  case $resp in
  1) packagesManager "$myBaseAudioPipeware" ;;
  2) packagesManager "$myBaseAudioPulse" ;;
  *) ;;
  esac
}

baseSetup() {
  echo "BASE
[1]Configure [2]No"
  read resp
  case $resp in
  1) packagesManager "$myBaseBootloader $myBaseFileSystem $myBaseNetwork $myBaseFirewall $myBaseUtilitys $myBaseBluetooth $myBaseCodecs $myBaseXorg $myBaseWayland $myBaseIcons $myBaseThemes $myBaseFonts $myBaseRar $myBaseNotify $myBaseDaemons $myBaseFlatpak $myBaseShell" ;;
  *) ;;
  esac
}

appsSetup() {
  echo "APPS
[1]Configure [2]No"
  read resp
  case $resp in
  1)
    packagesManager "$myBaseBrowser"
    packagesManager "$myBaseAudioApp"
    packagesManager "$myBaseVideoApp"
    packagesManager "$myBaseGraphicDesignApp"
    packagesManager "$myBaseSecurityApp"
    packagesManager "$myBaseDiskManagerApp"
    packagesManager "$myBaseOfficeApp"
    packagesManager "$myBaseVideoEditorApp"
    packagesManager "$myBaseCodingApp"
    packagesManager "$myBaseTorrentApp"
    packagesManager "$myBaseDiscordApp"
    packagesManager "$myBaseConnectApp"
    ;;
  *) ;;
  esac
}

startSetup() {
  enableSystemctl "bluetooth"
  enableSystemctl "NetworkManager"
  enableSystemctl "power-profiles-daemon"
  enableSystemctl "sshd"
}

sambaSetup() {
  echo "SAMBA
[1]Configure [2]No"
  read -r resp
  case $resp in
  1)
    sudo pacman -S --needed samba
    sudo smbpasswd -a "$USER"
    sudo smbpasswd -e "$USER"

    RAND=$(cat /dev/urandom | tr -dc 'A-Z0-9' | head -c 6)
    NETBIOS_NAME="Samba$RAND"

    echo "Using NetBIOS name: $NETBIOS_NAME"

    sudo mv /etc/samba/smb.conf /etc/samba/smb-bkp$DATANOW.conf

    mkdir -p "$HOME/Samba/User"
    sudo chmod 777 "$HOME/Samba"
    sudo mkdir -p /home/samba
    sudo chmod 777 /home/samba

    echo "[global]
    workgroup = WORKGROUP
    preferred master = no
    local master = no
    domain master = no
    netbios name = $NETBIOS_NAME
    server string = Samba Server
    server role = standalone server
    security = user
    map to guest = bad user
    guest account = nobody
    log file = /var/log/samba/%m
    log level = 1
    dns proxy = no
[printers]
    comment = All Printers
    path = /usr/spool/samba
    browsable = no
    guest ok = no
    writable = no
    printable = yes
[User]
    comment = Pasta Compartilhada na Rede
    path = $HOME/Samba/User
    browseable = yes
    read only = yes
    guest ok = no
    write list = $USER
    force directory mode = 0777
    directory mode = 0777
    create mode = 0777
[Guest]
    comment = Pasta Compartilhada na Rede
    path = /home/samba
    browseable = yes
    read only = yes
    guest ok = yes
    write list = $USER
    force directory mode = 0777
    directory mode = 0777
    create mode = 0777" | sudo tee /etc/samba/smb.conf >/dev/null

    ln -s /home/samba "$HOME/Samba/Guest"
    enableSystemctl "smb"
    enableSystemctl "nmb"
    #sudo systemctl restart smbd nmbd
    #sudo useradd -m samba
    #sudo passwd samba
    ;;
  *) ;;
  esac
}

configsSetup() {
  echo "CONFIGS
[1]Configure [2]No"
  read resp
  case $resp in
  1)
    flatpak override --user --filesystem=~/.icons:ro --filesystem=~/.local/share/icons:ro
    sudo rm -f /usr/share/applications/rofi*
    myBaseI3Backlight
    myBaseI3Touchpad
    lidSwitchIgnore
    criaAtalho "Wiremix Audio" "Audio Tui" "wiremix" "$HOME" "true" "Wiremix" "pavucontrol"
    ;;
  *) ;;
  esac
}

desktopSetup() {
  echo "DESKTOP
[1]Hyprland [2]I3wm [3]Gnome [4]KDE [5]Xfce"
  read resp
  case $resp in
  1)
    packagesManager "$myBaseHyprland $wmDisplayManager $wmBaseFileManager $wmBaseTerminal $wmBasePdfApp"
	#hyprland
    ;;
  2)
    packagesManager "$myBaseI3wm $wmDisplayManager $wmBaseFileManager $wmBaseTerminal $wmBasePdfApp"
	#startx /usr/bin/i3
    ;;
  3)
    packagesManager "$myBaseGnome"
    enableSystemctl "gdm"
    ;;
  4)
    packagesManager "$myBaseKde"
    enableSystemctl "sddm"
    ;;
  5)
    packagesManager "$myBaseXfce4"
    enableSystemctl "lightdm"
    ;;
  *) ;;
  esac
}

############
###OUTROS###
############

lightdmConfig() {
  echo "[greeter]
theme-name = Breeze-Dark
icon-theme-name = Papirus-Dark
cursor-theme-name = Adwaita
indicators = ~session;~spacer;~clock;~spacer;~power
background = /usr/share/backgrounds/main.png
font-name = Caskaydia Mono Nerd Font 11" | sudo tee -a /etc/lightdm/lightdm-gtk-greeter.conf
}

myBaseI3Touchpad() {
  sudo mkdir -p /etc/X11/xorg.conf.d && sudo tee /etc/X11/xorg.conf.d/90-touchpad.conf <<'EOF' 1>/dev/null
Section "InputClass"
Identifier "touchpad"
MatchIsTouchpad "on"
Driver "libinput"
Option "Tapping" "on"
EndSection
EOF
}

installVirtManager() {
  packagesManager "$myBaseVirt" "VirtManager"
  enableSystemctl "libvirtd"
  sudo virsh net-autostart default
  #sudo virsh net-start default
}

myBaseI3Backlight() {
  #sudo chmod +s /usr/bin/light
  echo 'ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp wheel $sys$devpath/brightness", RUN+="/bin/chmod g+w $sys$devpath/brightness"' | sudo tee /etc/udev/rules.d/backlight.rules
  #criarArq 'light' "$HOME/.config/i3/brightness"
}

lidSwitchIgnore() {
  sudo sed -i 's/^#HandleLidSwitch=suspend/HandleLidSwitch=ignore/' /etc/systemd/logind.conf
  sudo sed -i 's/^HandleLidSwitch=suspend/HandleLidSwitch=ignore/' /etc/systemd/logind.conf
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

## Olds ##

appPosNetwork() {
  echo "[ARCH] Network"
  echo "INSTALAR NETWORKMANAGER"
  packagesManager "networkmanager nm-connection-editor network-manager-applet"
  #sudo systemctl enable NetworkManager.service
  #sudo systemctl start NetworkManager.service --now
  enableSystemctl "NetworkManager"
  #echo "REMOVER IWD (wifi terminal archinstall)"
  #removePacotes "iwd"
}

appPosNvidiaDriverProp() {
  #https://github.com/lutris/docs/blob/master/InstallingDrivers.md#arch--manjaro--other-arch-linux-derivatives
  #causa crash no gdm o pacote: nvidia-dkms
  #https://codigocristo.github.io/driver_nvidia.html
  #packagesManager "$myBaseNvidia"
  packagesManager "nvidia-open nvidia-utils lib32-nvidia-utils nvidia-settings"
  echo "https://github.com/korvahannu/arch-nvidia-drivers-installation-guide"
  sleep 10
}

appPosManualConfig() {
  echo "---------------------
Configuracoes Manuais
---------------------
[PACMAN]
Remover comentarios em: /etc/pacman.conf
#Color
#ParallelDownloads = 10
ILoveCandy
#[multilib]
#Include = /etc/pacman.d/mirrorlist
---------------------
[GNOME]
Remover comentarios em: /etc/gdm3/custom.conf
#WaylandEnable=false
Apos editar, executar:
sudo systemctl restart gdm3
---------------------
[THEME]
Caso de erro com thema no i3 é so apagar as pastas gtk-* em .config na HOME
---------------------
[NVIDIA]
https://github.com/korvahannu/arch-nvidia-drivers-installation-guide
configurar no Xorg com
sudo nvidia-xconfig
---------------------
[GRUB]
sudo nano /etc/default/grub
remover # da opcao 
#GRUB_DISABLE_OS_PROBER=false
apos isso executar
grub-mkconfig -o /boot/grub/grub.cfg
---------------------
[Steam Linux & Windows]
https://github.com/ValveSoftware/Proton/wiki/Using-a-NTFS-disk-with-Linux-and-Windows
"
  read enterprasair
}

appPosBluetoothFix() {
  echo "[1]Fix Bluetooth & Network Interference [2]Remove Fix"
  read esco
  if [ "$esco" = "1" ]; then
    sudo tee /etc/modprobe.d/iwlwifi-opt.conf <<<"options iwlwifi bt_coex_active=N"
  elif [ "$esco" = "2" ]; then
    sudo rm /etc/modprobe.d/iwlwifi-opt.conf
  fi
}

appPosTecladoConfig() {
  echo "[ARCH] Keyboard BR"
  setxkbmap -model abnt2 -layout br
  #echo "setxkbmap -model abnt2 -layout br" >> ~/.profile
  sudo tee /etc/X11/xorg.conf.d/10-evdev.conf <<<'Section "InputClass"
Identifier "evdev keyboard catchall"
MatchIsKeyboard "on"
MatchDevicePath "/dev/input/event*"
Driver "evdev"
Option "XkbLayout" "br"
Option "XkbVariant" "abnt2"
EndSection'
}

appPosTimeNTP() {
  sudo timedatectl set-ntp true
  sudo hwclock --systohc
}

xfce4Config() {
  xfce4-panel --quit
  pkill xfconfd
  rm -rf ~/.config/xfce4/panel
  rm -rf ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
  xfce4-config
  xfce4-panel &
}

gsettingsInactiveOn() {
  xset s on +dpms
  gsettings set org.gnome.desktop.session idle-delay 300
  gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'suspend'
  gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 600
  gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'suspend'
  gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 300
}

gsettingsInactiveOff() {
  xset s off -dpms
  gsettings set org.gnome.desktop.session idle-delay 0
  gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
  gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
  gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
  gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 0
}

defaultInodeDirectory() {
  echo "Default Applications   
[1]Nautilus for FileManager
[2]PCManFM for FileManager
[3]Thunar for FileManager"
  read resp
  case $resp in
  1) xdg-mime default org.gnome.Nautilus.desktop inode/directory ;;
  2) xdg-mime default pcmanfm.desktop inode/directory ;;
  3) xdg-mime default thunar.desktop inode/directory ;;
  *) ;;
  esac
}

hyprlandDiscordX() {
  criaAtalho "DiscordX (Flatpak)" "Discord em Xwayland" "env ELECTRON_OZONE_PLATFORM_HINT= com.discordapp.Discord --no-sandbox" "$HOME" "false" "discordFlatpak" "discord"
  criaAtalho "DiscordX (Pacman)" "Discord em Xwayland" "env ELECTRON_OZONE_PLATFORM_HINT= discord --no-sandbox" "$HOME" "false" "discordPacman" "discord"
}

#https://developer.valvesoftware.com/wiki/SteamCMD#Linux
#essa linha corrige possiveis erros restaurando as configuracoes padrao do SteamCMD validando-as
#bash ./steamcmd.sh +login anonymous +app_update 1110390 validate +quit

serversLinuxUser() {
	linuxUserServer="servers"
	packagesManager "screen"
	if id "$linuxUserServer" >/dev/null 2>&1; then
		echo "O usuário '$linuxUserServer' já existe. Ignorando a criação do usuário."
		sudo -u $linuxUserServer -s
	else
		echo "O usuário '$linuxUserServer' não foi encontrado. Criando usuário..."
		sudo useradd -m $linuxUserServer
		if [ $? -eq 0 ]; then
			echo "Usuário '$linuxUserServer' criado com sucesso."
			echo "senha para $linuxUserServer:"
			sudo passwd $linuxUserServer
			sudo -u $linuxUserServer -s
		else
			echo "Erro: Falha ao criar o usuário '$linuxUserServer'."
		fi
	fi
	# sudo userdel servers
}

installSteamCMD() {
	packagesManager "steamcmd"
}

installFivem() {
	verFivem0="https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/6136-97e3790629f188c887ee11d119d7a705c8a9f9f0/fx.tar.xz"
	verFivem="https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/7290-a654bcc2adfa27c4e020fc915a1a6343c3b4f921/fx.tar.xz"
	cfxData="https://github.com/citizenfx/cfx-server-data/archive/refs/heads/master.zip"
	modMenu="https://github.com/TomGrobbe/vMenu/releases/download/v3.5.0/vMenu-v3.5.0.zip"
	pvpMode="https://github.com/fcarvalho-bruno/enablepvp/archive/refs/heads/master.zip"
	handEditor="https://github.com/FRANkiller13/FiveM-Handling-Editor/archive/refs/heads/master.zip"
	streetRace="https://github.com/bepo13/FiveM-StreetRaces/archive/refs/heads/master.zip"
	modCars="https://github.com/25danijelmesec03/FiveM-Car-Pack-1/archive/refs/heads/main.zip"
	fixHoles="https://github.com/Bob74/bob74_ipl/archive/refs/heads/master.zip"
	carCmd="https://forum.cfx.re/uploads/default/original/3X/3/9/394edb23c58fc64e23411306a40e63788a3a587b.zip"

	echo "FIVEM NAME FOLDER"
	read fivemNome
	uninstallPastaAtalhoBinMesmoNome "$fivemNome"

	echo -e "[INFO] - INSTALANDO FIVEM SERVER - [INFO]"
	criaDiretorio "diretorioServer" "$JRS_DIR/$fivemNome"
	criaPastaBaixaExtrai "$diretorioServer" "$verFivem" "fx.tar.xz"

	criaPastaBaixaExtrai "$diretorioServer" "$cfxData" "data.zip"
	mv $diretorioServer/cfx-* $diretorioServer/server-data

	criaDiretorio "diretorioResource" "$diretorioServer/server-data/resources/[jhonatanrs]"

	criaPastaBaixaExtrai "$diretorioServer/server-data/resources/vMenu" "$modMenu" "modmenu.zip"
	criaPastaBaixaExtrai "$diretorioResource/" "$handEditor" "handEditor.zip"
	criaPastaBaixaExtrai "$diretorioResource/" "$pvpMode" "pvpMode.zip"
	criaPastaBaixaExtrai "$diretorioResource/" "$streetRace" "streetRace.zip"
	#criaPastaBaixaExtrai "$diretorioResource/" "$modCars" "modCars.zip"
	criaPastaBaixaExtrai "$diretorioResource/" "$fixHoles" "fixHoles.zip"
	#criaPastaBaixaExtrai "$diretorioResource/" "$carCmd" "carCmd.zip"

	mv $diretorioResource/FiveM-StreetRaces-master/StreetRaces $diretorioResource/StreetRaces
	rm -r $diretorioResource/FiveM-StreetRaces-master
	# cp $diretorioResource/vMenu/config/permissions.cfg $diretorioServer/server-data/permissions.cfg

	echo -e "License key for your server (https://keymaster.fivem.net)"
	read lk

	criarArq "#!/bin/bash
cd $diretorioServer/server-data && bash $diretorioServer/run.sh +exec server.cfg" "$diretorioServer/fivemexec.sh"

	#remove NPCs
	addNoArq '
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    SetVehicleDensityMultiplierThisFrame(0.0)
    SetPedDensityMultiplierThisFrame(0.0)
  end
end)' "$diretorioServer/server-data/resources/[gamemodes]/basic-gamemode/basic_client.lua"

	criarArq "<style type=text/css>
    body {
        background-color: white;
        background-image: url(loadscreen2.jpg);
        background-size: 30%;
        background-repeat: no-repeat;
        background-position-x: center;
        background-position-y: -25%;
    }
</style>" "$diretorioServer/server-data/resources/[test]/example-loadscreen/index.html"

	addNoArq '# Only change the IP if youre using a server with multiple network interfaces, otherwise change the port only.
endpoint_add_tcp 0.0.0.0:30120
endpoint_add_udp 0.0.0.0:30120


# These resources will start by default.
ensure mapmanager
ensure chat
ensure spawnmanager
ensure sessionmanager
ensure basic-gamemode
ensure hardcap
ensure rconlog

# minhas configs
exec resources/vMenu/config/permissions.cfg
start vMenu
start [jhonatanrs]
start example-loadscreen

# This allows players to use scripthook-based plugins such as the legacy Lambda Menu.
# Set this to 1 to allow scripthook. Do note that this does _not_ guarantee players wont be able to use external plugins.
sv_scriptHookAllowed 0

# Uncomment this and set a password to enable RCON. Make sure to change the password - it should look like rcon_password "YOURPASSWORD"
#rcon_password 

# A comma-separated list of tags for your server.
# For example:
# - sets tags drifting, cars, racing
# Or:
# - sets tags roleplay, military, tanks
sets tags roleplay, drifting, cars, racing

# A valid locale identifier for your servers primary language.
# For example en-US, fr-CA, nl-NL, de-DE, en-GB, pt-BR
sets locale pt-BR 
# please DO replace root-AQ on the line ABOVE with a real language! :)

# Set an optional server info and connecting banner image url.
# Size doesnt matter, any banner sized image will be fine.
#sets banner_detail https://url.to/image.png
#sets banner_connecting https://url.to/image.png

# Set your servers hostname. This is not usually shown anywhere in listings.
sv_hostname "Jardim Recreio"

# Set your servers Project Name
sets sv_projectName "Jardim Recreio"

# Set your servers Project Description
sets sv_projectDesc "Um bairro pra garotada brincar."

# Nested configs!
#exec server_internal.cfg

# Loading a server icon (96x96 PNG file)
load_server_icon myLogo.png

# convars which can be used in scripts
set temp_convar "Bem Vindo ao Bairro!"

# Remove the # from the below line if you want your server to be listed as private in the server browser.
# Do not edit it if you *do not* want your server listed as private.
# Check the following url for more detailed information about this:
# https://docs.fivem.net/docs/server-manual/server-commands/#sv_master1-newvalue
#sv_master1 

# Add system admins
add_ace group.admin command allow # allow all commands
add_ace group.admin command.quit deny # but dont allow quit
add_principal identifier.fivem:1 group.admin # add the admin to the group

# enable OneSync (required for server-side state awareness)
set onesync on

# Server player slot limit (see https://fivem.net/server-hosting for limits)
sv_maxclients 10

# Steam Web API key, if you want to use Steam authentication (https://steamcommunity.com/dev/apikey)
# -> replace  with the key
set steam_webApiKey

# License key for your server (https://keymaster.fivem.net)
sv_licenseKey '"$lk"'' "$diretorioServer/server-data/server.cfg"

	criaAtalhoBin "$diretorioServer/fivemexec.sh" "$fivemNome"
}

installMinecraftServer() {
	uninstallPastaAtalhoBinMesmoNome "MinecraftServer"
	link="https://piston-data.mojang.com/v1/objects/4707d00eb834b446575d89a61a11b5d548d8c001/server.jar"

	echo -e "[INFO] - CRIANDO DIRETORIOS... - [INFO]"
	criaDiretorioInstall "$JRS_DIR/MinecraftServer"

	echo -e "[INFO] - BAIXANDO ARQUIVOS... - [INFO]"
	baixaArq "diretorioNome" "$link" "$diretorioInstall/server.jar"

	echo -e "[INFO] - INSTALANDO - [INFO]"

	java -jar server.jar nogui

	addNoArq "eula=true" "eula.txt"

	addNoArq "online-mode=false
motd=\u00A71Jardim Recreio  \u00A77By Jhonatanrs
server-port=25565
enable-command-block=true" "server.properties"

	criarArq "#!/usr/bin/env bash
#echo 'EM CASO DE ERRO VERIFIQUE A VERSAO DO JAVA
#Press ENTER'
#read caso
cd $diretorioInstall
java -jar server.jar nogui" "run.sh"

	criaAtalho "MinecraftServer" "Create your own Minecraft Server" "bash run.sh" "$diretorioInstall" "true" "Minecraft Server" "/usr/share/icons/Papirus-Dark/64x64/apps/mine-test.svg"
	criaAtalhoBin "$diretorioInstall/run.sh" "MinecraftServer"
	echo -e "[INFO] - SCRIPT FINALIZADO - [INFO]"
}

sampServer() {

	installName="SampServer"
	uninstallPastaAtalhoBinMesmoNome "$installName"
	criaDiretorioInstall "$JRS_DIR/$installName"

	criaPastaBaixaExtrai "$diretorioInstall" "http://files.sa-mp.com/samp037svr_R2-1.tar.gz" "samp.tar.gz"
	mv */* .

	criarArq "#!/bin/bash
cd $diretorioInstall
./samp03svr" "$diretorioInstall/run.sh"

	criarArq "echo Executing Server Config...
lanmode 1
rcon_password 0
maxplayers 20
port 7777
hostname Jardim Recreio
gamemode0 grandlarc 1
filterscripts base gl_actions gl_property gl_realtime
announce 0
query 1
weburl www.sa-mp.com
maxnpc 0
onfoot_rate 40
incar_rate 40
weapon_rate 40
stream_distance 300.0
stream_rate 1000" "$diretorioInstall/server.cfg"

	criaAtalho "$installName" "Server SAMP em Segundo Plano" "./samp03svr" "$diretorioInstall" "true" "$installName" "application-default-icon"
	criaAtalhoBin "$diretorioInstall/run.sh" "$installName"

}

terrariaServer() {
	installName="TerrariaServer"
	uninstallPastaAtalhoBinMesmoNome "$installName"
	criaDiretorioInstall "$JRS_DIR/$installName"
	criaPastaBaixaExtrai "$diretorioInstall" "https://terraria.org/api/download/pc-dedicated-server/terraria-server-1449.zip" "ts.zip"
	chmod 770 $diretorioInstall/*/Linux/TerrariaServer.bin.x86_64
	criaArqRunDiretorioInstall "#!/bin/bash
cd $diretorioInstall/*/Linux
./TerrariaServer.bin.x86_64"
	criaAtalho "$installName" "Terraria Server PC" "bash run.sh" "$diretorioInstall" "true" "$installName" "application-default-icon"
	criaAtalhoBin "$diretorioInstall/run.sh" "$installName"
}

installUnturnedServer() {

	installName="UnturnedServer"
	uninstallPastaAtalhoBinMesmoNome "$installName"
	criaDiretorioInstall "$JRS_DIR/$installName"

	criarArq "Name JardimRecreio
Map PEI
Maxplayers 10
Port 27015
perspective both
mode normal
pve
welcome Bem Vindo ao bairro!!
cheats on" "$HOME/.steam/SteamApps/common/U3DS/Servers/JardimRecreio/Server/Commands.dat"

	criarArq "#!/bin/bash
steamcmd +login anonymous +app_update 1110390 +quit
cd $HOME/.steam/SteamApps/common/U3DS
bash ServerHelper.sh +LanServer/JardimRecreio" "$diretorioInstall/run.sh"

	#criaAtalhoBin "$diretorioInstall/run.sh" "$installName"

}

installProjectZomboidServer() {
	installName="PZserver"
	uninstallPastaAtalhoBinMesmoNome "$installName"
	criaDiretorioInstall "$JRS_DIR/$installName"
	installSteamCMD
	criarArq "steamcmd +force_install_dir "$diretorioInstall" +login anonymous +app_update 380870 validate +quit" "run_install_and_update.sh" # 108600 ou 380870
}

installPalworldServer() {
	installName="PalServer"
	uninstallPastaAtalhoBinMesmoNome "$installName"
	criaDiretorioInstall "$JRS_DIR/$installName"
	installSteamCMD
	criarArq "steamcmd +@sSteamCmdForcePlatformType linux +force_install_dir "$diretorioInstall" +login anonymous +app_update 2394010 validate +quit" "run_install_and_update.sh"
	criarArq "chmod +x PalServer.sh
./PalServer.sh -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS" "run_server.sh"
}

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
        criarArq "#!/bin/bash
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

# DOCs
#https://github.com/ValveSoftware/gamescope/issues/1800
#MANGOHUD_CONFIG="read_cfg" MANGOHUD_CONFIGFILE="$HOME/.config/MangoHud/MangoHud.conf" gamescope --adaptive-sync --hdr-enabled -W 3840 -H 2160 -f --steam --mangoapp -- /usr/bin/steam -gamepadui

#https://github.com/shahnawazshahin/steam-using-gamescope-guide/wiki/Steam-using-Gamescope-guide-%E2%80%90-Wiki-page
#gamescope -e -- steam -steamdeck -steamos3

#ARCHWIKI
#steam gamescope mangohud gamemode

#GAMESCOPE
#--expose-wayland na nvidia causa bug na tela

#Arranque
#CS2
#WLR_XWAYLAND=/usr/bin/Xwayland gamescope -w 1024 -h 768 -W 1024 -H 768 -r 75 -S stretch -f --immediate-flips --rt --force-grab-cursor --mangoapp -- %command%

steamos-config() {
	sudo setcap 'CAP_SYS_NICE=eip' $(which gamescope)
	sudo tee /etc/modprobe.d/nvidia-modeset.conf <<<'options nvidia_drm modeset=1 fbdev=1'
	sudo usermod -aG gamemode $USER
}

steamos-setup() {
	packagesManager "$myBaseSteam $myBaseMangoHud $myBaseGamescope"
	SESSION_NAME="SteamOS"
	FILENAME="jrs-${SESSION_NAME}Mode.desktop"
	EXITFILENAME="jrs-${SESSION_NAME}Exit.sh"
	EXEC_COMMAND="sh -c 'gamescope -w 1600 -h 900 -W 1600 -H 900 -S stretch -f -C 5000 -e --cursor Adwaita --force-grab-cursor --mangoapp -- steam -steamdeck -steamos3'"
	APP_DIR="$HOME/.local/share/applications/jrs"
	SESSION_DIR="/usr/share/xsessions"
	#/usr/share/xsessions
	#/usr/share/wayland-sessions
	echo "SteamOSMode
[1] App, [2] Session, [3] Config"
	read resp
	case $resp in
	1) steamos-app ;;
	2) steamos-session ;;
	3) steamos-config ;;
	*) ;;
	esac
}

steamos-app() {
	echo "SteamOSMode
[1] Criar App, [2] Remover App"
	read resp
	case $resp in
	1)
		sudo mkdir -p "$APP_DIR"
		cat <<EOF | sudo tee "${APP_DIR}/${FILENAME}"
[Desktop Entry]
Name=${SESSION_NAME} Mode
Comment=Uma sessão de games com aparência de SteamOS.
Exec=${EXEC_COMMAND}
Icon=steam
Type=Application
Categories=Game;
EOF
		sudo chmod 777 "${APP_DIR}/${FILENAME}"
		;;
	2)
		sudo rm $APP_DIR/$FILENAME
		;;
	*) ;;
	esac
}

steamos-session() {
	echo "SteamOSMode
[1] Criar Sessão, [2] Remover Sessão"
	read resp
	case $resp in
	1)
		sudo mkdir -p "$SESSION_DIR"
		cat <<EOF | sudo tee "${SESSION_DIR}/${FILENAME}"
[Desktop Entry]
Name=${SESSION_NAME} Mode
Comment=Uma sessão de games com aparência de SteamOS.
Exec=${EXEC_COMMAND}
Icon=steam
Type=Application
Categories=Game;
EOF
		cat <<EOF | sudo tee "${APP_DIR}/${EXITFILENAME}"
#!/bin/bash
steam -shutdown
EOF
		sudo chmod 777 "${SESSION_DIR}/${FILENAME}"
		sudo chmod 777 "${APP_DIR}/${EXITFILENAME}"
		;;
	2)
		sudo rm $SESSION_DIR/$FILENAME
		sudo rm $APP_DIR/$EXITFILENAME
		;;
	*) ;;
	esac
}

enableSystemctl() {
	SERVICE_NAME="$1"

	# 1. Verifica se o serviço JÁ ESTÁ habilitado.
	# O comando retorna 0 se habilitado, e 1 ou mais se desabilitado/mascarado.
	if systemctl is-enabled "$SERVICE_NAME" >/dev/null 2>&1; then
		#echo "✅ O serviço $SERVICE_NAME já está HABILITADO. Ignorando a ativação."
		return # Sai da função após a verificação
	fi

	# 2. Se não estiver habilitado, exibe o prompt original:
	echo "⚠️ O serviço $SERVICE_NAME não está habilitado."
	echo "Opções: [1] Habilitar (enable)"
	read -r resp
	case $resp in
	1)
		echo "Habilitando e iniciando $SERVICE_NAME..."
		sudo systemctl enable "$SERVICE_NAME" --now
		echo "O serviço $SERVICE_NAME foi habilitado e iniciado."
		;;
	*)
		echo "Opção inválida. Nenhuma alteração feita."
		;;
	esac
}

disableSystemctl() {
	SERVICE_NAME="$1"

	# 1. Verifica se o serviço JÁ ESTÁ habilitado.
	# O comando retorna 0 se habilitado, e 1 ou mais se desabilitado/mascarado.
	if systemctl is-enabled "$SERVICE_NAME" >/dev/null 2>&1; then
		echo "⚠️ O serviço $SERVICE_NAME está habilitado."
		echo "Opções: [1] Desabilitar (disable)"
		read -r resp
		case $resp in
		1)
			# Desabilitar um serviço que já não está habilitado não causará erro,
			# mas é incluído para consistência com as opções do usuário.
			echo "Desabilitando (se aplicável) $SERVICE_NAME..."
			sudo systemctl disable "$SERVICE_NAME"
			echo "O serviço $SERVICE_NAME foi desabilitado."
			;;
		*)
			echo "Opção inválida. Nenhuma alteração feita."
			;;
		esac
	fi

}

virtualGamepads(){
    echo "Dependencias"
    packagesManager "nodejs-lts-hydrogen npm"
    installName="VirtualGamepads"
    uninstallPastaAtalhoBinMesmoNome "$installName"
    criaDiretorioInstall "$JRS_DIR/$installName"
    criaPastaBaixaExtrai "$diretorioInstall" "https://codeload.github.com/jehervy/node-virtual-gamepads/zip/refs/heads/master" "nvg.zip"
    mv */* .
    npm install
    sudo npm install -g qrcode-terminal
    echo '#!/bin/bash
	cd '"$diretorioInstall"'
    sudo echo http://$(ip route get 1 | sed -n '"'"'s/.*src \([0-9.]\+\).*/\1/p'"'"'):80 | qrcode-terminal
    sudo node main.js' > $diretorioInstall/run.sh
    criaAtalho "Virtual Gamepads" "Virtual Gamepads Linux" "bash run.sh" "$diretorioInstall" "true" "$installName" "$diretorioInstall/public/images/SNES_controller.svg"
    #criaAtalhoBin "$diretorioInstall/run.sh" "$installName"

}  

installRedeVirtual(){
        echo "Rede Virtual
[1] Zerotier, [2] Ngrok [3] Playit.gg"
    read resp
    case $resp in
		1)installZerotier;;
        2)installNgrok;;
        3)installPlayITGG;;
		*);;
	esac
}

installZerotier(){
    roomZerotier="d3ecf5726df2c372"
    echo "Zerotier para Ubuntu[1] ou Arch[2]"
    read escolha
    if [ "$escolha" = "1" ]; then
        sudo dpkg --configure -a
        curl -s 'https://raw.githubusercontent.com/zerotier/ZeroTierOne/master/doc/contact%40zerotier.com.gpg' | gpg --import && \
        if z=$(curl -s 'https://install.zerotier.com/' | gpg); then echo "$z" | sudo bash; fi
        enableSystemctl "zerotier-one"
        sudo zerotier-cli join $roomZerotier
    elif [ "$escolha" = "2" ]; then
        echo "PAMAC ou PACMAN"
        packagesManager "zerotier-one"
        enableSystemctl "zerotier-one"
        sudo zerotier-cli join $roomZerotier
    fi 
   
}

installNgrok(){
    #https://github.com/ChaoticWeg/discord.sh
    arqNgrok="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz"
    arqDiscord="https://github.com/ChaoticWeg/discord.sh/archive/refs/heads/master.zip"
    uninstallPastaAtalhoBinMesmoNome "Ngrok"
    echo -e "[INFO] - DEPENDENCIAS - [INFO]"
    criaDiretorio "diretorioNgrok" "$JRS_DIR/Ngrok"
    baixaArq "diretorioNome" "$arqNgrok" "$diretorioNgrok/ngrok.tgz"
    baixaArq "diretorioNome" "$arqDiscord" "$diretorioNgrok/bot.zip"
    echo -e "[INFO] - INSTALANDO NGROK - [INFO]"
	cd $diretorioNgrok
	extrairArq "$diretorioNgrok"
    mv discord* discord
	echo -e "
Connect your account (https://ngrok.com/)\nEx.:ngrok config add-authtoken ******"
	read auth_key
	./$auth_key
    criarArq "#!/bin/bash
bash $diretorioNgrok/discord.sh & bash $diretorioNgrok/ngrok.sh" "$diretorioNgrok/start.sh"
    criarArq "#!/bin/bash
	cd $diretorioNgrok
	./ngrok tcp 25565" "$diretorioNgrok/ngrok.sh"
	echo -e "
COLE AQUI O LINK DA API DO BOT WEBHOOK DO DISCORD"
	read webh
    criarArq '#!/bin/bash
sleep 15
WEBHOOK="'$webh'"
ServerIp=`curl -s localhost:4040/api/tunnels | jq -r .tunnels[0].public_url`
ServerIp=${ServerIp:6}
if [ -z "$ServerIp" ];then
    echo "VAZIO"
else
    bash '$PWD'/discord/discord.sh --webhook-url="$WEBHOOK" --title "IP DO SERVIDOR" --description "$ServerIp"
fi' "$diretorioNgrok/discord.sh"
	criaAtalhoBin "$diretorioNgrok/start.sh" "Ngrok"
}

installPlayITGG(){
    yay -S playit-bin
}

virtualPulseAudioReset() {
	pulseaudio -k
}

virtualPulseAudioInfo() {
	pactl info
}

virtualPulseAudioVars() {
	Input="alsa_input.pci-0000_00_1b.0.analog-stereo"
	Output="alsa_output.pci-0000_00_1b.0.analog-stereo"
}

virtualPulseAudioNullSink() {
	pactl load-module module-null-sink sink_name=$1 sink_properties=device.description=$1
}

virtualPulseAudioLoopback() {
	pactl load-module module-loopback source=$1 sink=$2 latency_msec=1
}

virtualPulseAudioRemap() {
	pactl load-module module-remap-source source_name=$1 source_properties=device.description=$1 master=$2
}

virtualPulseAudioNewInput() {
	pactl load-module module-virtual-source source_name=$1 source_properties=device.description=$1 master=$2
}

virtualPulseAudioSetDefault() {
	pactl set-default-sink "$1"
	pacmd set-default-source "$2"
}

testandoPA() {

	# Create the null sinks
	# virtual1 gets your audio sources (mplayer ...) that you want to hear and share
	# virtual2 gets all the audio you want to share (virtual1 + micro)
	pactl load-module module-null-sink sink_name=virtual1 sink_properties=device.description="Compartilhar-Audio" | tee -a "${module_file}"
	pactl load-module module-null-sink sink_name=virtual2 sink_properties=device.description="Intermediario" | tee -a "${module_file}"

	# Now create the loopback devices, all arguments are optional and can be configured with pavucontrol wiremix
	pactl load-module module-loopback source=virtual1.monitor sink="${SPEAKERS}" latency_msec=1 | tee -a "${module_file}"
	pactl load-module module-loopback source=virtual1.monitor sink=virtual2 latency_msec=1 | tee -a "${module_file}"
	pactl load-module module-remap-source source_name=virtual3 source_properties=device.description="Vmic" master=virtual2.monitor | tee -a "${module_file}"
	pactl load-module module-loopback source="${MICROPHONE}" sink=virtual2 latency_msec=1 | tee -a "${module_file}"

	# Make the default sink back to speakers
	pactl set-default-sink "${SPEAKERS}"
	pacmd set-default-source "virtual3"

}

virtualPulseAudioExec() {
	virtualPulseAudioReset
	virtualPulseAudioVars
	virtualPulseAudioNullSink "virtual1"
	virtualPulseAudioNullSink "virtual2"
	virtualPulseAudioLoopback "virtual1.monitor" "$Output"
	virtualPulseAudioLoopback "virtual1.monitor" "virtual2"
	virtualPulseAudioRemap "virtual3" "virtual2.monitor"
	#virtualPulseAudioNewInput "virtual3" "virtual2.monitor"
	virtualPulseAudioLoopback "$Input" "virtual2"
}

#virtualPulseAudioExec

bongo() {
	bongocat="https://github.com/kuroni/bongocat-osu/archive/refs/heads/master.zip"
	uninstallPastaAtalhoBinMesmoNome "winBongo"
	packagesManager "g++ gcc libxdo xdotool libxdo-dev libsdl2-dev libsfml-dev sdl2 sfml x11 xrandr make"
	echo -e "[INFO] - INSTALANDO BONGOCAT - [INFO]"
	criaDiretorio "diretorioBongo" "$JRS_DIR/winBongo"
	cd $diretorioBongo
	criaPastaBaixaExtrai "$diretorioBongo" "$bongocat" "bongo.zip"
	mv $diretorioBongo/*/* .
	#cp -r $diretorioBongo/*/* .
	cp Makefile.linux Makefile
	make
	mv $diretorioBongo/bin/bongo $diretorioBongo/bongo
	criarArq "#!/bin/bash
cd $diretorioBongo
./bongo" "$diretorioBongo/bongo.sh"
	criarArq '{
 "mode": 1,
    "resolution": {
        "letterboxing": false,
        "width": 1920,
        "height": 1080,
        "horizontalPosition": 0,
        "verticalPosition": 0
    },
    "decoration": {
        "leftHanded": false,
        "rgb": [255, 255, 255],
        "offsetX": [0, 11],
        "offsetY": [0, -65],
        "scalar": [1.0, 1.0]
    },
    "osu": {
        "mouse": true,
        "toggleSmoke": false,
        "paw": [198, 235, 254],
        "pawEdge": [2, 77, 164],
        "key1": [81, 65],
        "key2": [69, 68],
        "smoke": [220, 226, 45],
        "wave": [87, 83]
    },
    "taiko": {
        "leftCentre": [88],
        "rightCentre": [67],
        "leftRim": [90],
        "rightRim": [86]
    },
    "catch": {
        "left": [37],
        "right": [39],
        "dash": [16]
    },
    "mania": {
        "4K": true,
        "key4K": [68, 70, 74, 75],
        "key7K": [83, 68, 70, 32, 74, 75, 76]
    },
    "custom": {
        "background": "img/osu/mousebg.png",
        "mouse": false,
        "mouseImage": "img/osu/mouse.png",
        "mouseOnTop": true,
        "offsetX": 0,
        "offsetY": 0,
        "scalar": 1.0,
        "paw": [255, 255, 255],
        "pawEdge": [0, 0, 0],
        "keyContainers": []
    },
    "mousePaw": {
        "mousePawComment": "coordinates start in the top left of the window",
        "pawStartingPoint": [211, 159],
        "pawEndingPoint": [258, 228]
    }
}
' "$diretorioBongo/config.json"
	criaAtalho "BongoCat" "WEBCAM Avatar" "bash $diretorioBongo/bongo.sh" "$diretorioBongo" "false" "winBongo" "$diretorioBongo/ico/bongo.ico"
	criaAtalhoBin "$diretorioBongo/bongo.sh" "winBongo"
}

dependencies() {
	local wrapper="$JRS_DIR/.jrs.sh"
	local link_name="jrs"
	local link_path="/usr/bin/$link_name"

	# Verifica se o arquivo wrapper já existe
	if [ ! -f "$wrapper" ]; then
		echo "O atalho '$link_name' não existe. Criando agora..."

		# Cria o diretório se ele não existir
		mkdir -p "$(dirname "$wrapper")"

		# Cria o arquivo wrapper
		cat <<EOF >"$wrapper"
#!/usr/bin/env bash
cd "$PWD"
bash "jrs-run.sh"
EOF

		# Torna o arquivo executável
		chmod +x "$wrapper"
		echo "Arquivo wrapper criado em: $wrapper"
	fi

	# Verifica se o link simbólico existe e o cria se não
	if [ ! -L "$link_path" ]; then
		echo "O link simbólico para '$link_name' não existe. Criando agora..."
		sudo ln -sf "$wrapper" "$link_path"
		echo "Atalho '$link_name' criado com sucesso!"
	else
		echo "Atalho '$link_name' já está instalado."

	fi
	sleep 0
}

#
# Gerador de Resource de Skins Minecraft 1.8
# Importa a Skin em um Resource Pack de Textura possibilitando o uso da Skin sem Internet
# Mudando a skin do Steve e Alex para a skin do Resource Pack
#
# Como usar?
#
# Coloque as skins.png na pasta Skins (não coloque espaço no nome dos arquivos png) após isso execute o .sh
# Ex.: bash ./criarResourceDeSkin.sh
# Sera criado uma pasta resourcepacks com os Resource Pack
#

criaPackMCMeta(){
	echo '{
	  "pack": {
	    "pack_format": 1,
	    "description": "By Jhonatanrs"
	  }
	}' >> pack.mcmeta
}

crop1ponto7Skins(){
	# usando o ImageMagick cortamos a imagem para a versão 1.7 64x32 px
	#sudo apt-get install imagemagick
	for skin in `ls Skins`
	do
		mkdir -p Skins-Convertidas
		convert Skins/$skin -crop 64x64+0-32 Skins-Convertidas/OLD-$skin
		cp -a Skins/$skin Skins-Convertidas/NEW-$skin
	done
}

criaResourcesSkins(){
	for skin in `ls Skins-Convertidas`
	do
		mkdir -p novaSource/assets/minecraft/textures/entity
		cd novaSource
		criaPackMCMeta
		cd ..
		mkdir -p resourcepacks
		cp -a Skins-Convertidas/$skin novaSource/assets/minecraft/textures/entity/alex.png
		cp -a Skins-Convertidas/$skin novaSource/assets/minecraft/textures/entity/steve.png
		cp -a Skins-Convertidas/$skin novaSource/pack.png
		cd novaSource 
		zip -r ${skin::-4}.zip *
		mv ${skin::-4}.zip ../resourcepacks
		cd ..
		rm -r novaSource
	done
}

GeradorResourceSkinsMinecraft(){
	crop1ponto7Skins
	criaResourcesSkins
	rm -r Skins-Convertidas
}
