#!/bin/bash
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
