#!/bin/bash

install_zerotier() {
	roomZerotier="d3ecf5726df2c372"
	sudo pacman -S zerotier-one --needed
	sudo systemctl enable "zerotier-one" --now
	sudo zerotier-cli join $roomZerotier
}

install_ngrok() {
	source $HOME/.dotfiles/jrs/.config/jrs/jrs-scripts-others.sh
	source $HOME/.dotfiles/jrs/.config/jrs/jrs-scripts-create.sh
	source $HOME/.dotfiles/jrs/.config/jrs/jrs-scripts-extract-file.sh
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
	extract_file "$diretorioNgrok"
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

install_playit() {
	yay -S playit-bin
}

install_rede_virtual() {
	echo "Rede Virtual
[1] Zerotier, [2] Ngrok [3] Playit.gg"
	read resp
	case $resp in
	1) install_zerotier ;;
	2) install_ngrok ;;
	3) install_playit ;;
	*) ;;
	esac
}