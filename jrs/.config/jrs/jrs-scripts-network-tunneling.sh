#!/bin/bash

install_zerotier() {
	roomZerotier="d3ecf5726df2c372"
	sudo pacman -S zerotier-one --needed
	sudo systemctl enable "zerotier-one" --now
	sudo zerotier-cli join $roomZerotier
}

install_ngrok() {
	source $HOME/.dotfiles/jrs/.config/jrs/jrs-scripts-create-shortcut.sh
	source $HOME/.dotfiles/jrs/.config/jrs/jrs-scripts-file.sh
	#https://github.com/ChaoticWeg/discord.sh
	arqNgrok="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz"
	arqDiscord="https://github.com/ChaoticWeg/discord.sh/archive/refs/heads/master.zip"
	diretorioNgrok="$JRS_DIR/ngrok"
	mkdir -p $diretorioNgrok
	download_file "directory_name" "$arqNgrok" "$diretorioNgrok/ngrok.tgz"
	download_file "directory_name" "$arqDiscord" "$diretorioNgrok/bot.zip"
	echo -e "[INFO] - INSTALANDO NGROK - [INFO]"
	cd $diretorioNgrok
	extract_file "$diretorioNgrok"
	mv discord* discord
	echo -e "
Connect your account (https://ngrok.com/)\nPast Your Authtoken:"
	read auth_key
	./ngrok config add-authtoken $auth_key
	echo "#!/bin/bash
bash $diretorioNgrok/discord.sh & bash $diretorioNgrok/ngrok.sh" >$diretorioNgrok/start.sh
	echo "#!/bin/bash
	cd $diretorioNgrok
	./ngrok tcp 25565" >$diretorioNgrok/ngrok.sh
	echo -e "
COLE AQUI O LINK DA API DO BOT WEBHOOK DO DISCORD"
	read webh
	echo '#!/bin/bash
sleep 15
WEBHOOK="'$webh'"
ServerIp=`curl -s localhost:4040/api/tunnels | jq -r .tunnels[0].public_url`
ServerIp=${ServerIp:6}
if [ -z "$ServerIp" ];then
    echo "VAZIO"
else
    bash '$PWD'/discord/discord.sh --webhook-url="$WEBHOOK" --title "IP DO SERVIDOR" --description "$ServerIp"
fi' >$diretorioNgrok/discord.sh
	create_shortcut_bin "$diretorioNgrok/start.sh" "ngrok"
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