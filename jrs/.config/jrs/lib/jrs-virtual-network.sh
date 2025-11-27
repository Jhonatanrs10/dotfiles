#!/usr/bin/env sh
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
    criarArq "#!/usr/bin/env sh
bash $diretorioNgrok/discord.sh & bash $diretorioNgrok/ngrok.sh" "$diretorioNgrok/start.sh"
    criarArq "#!/usr/bin/env sh
	cd $diretorioNgrok
	./ngrok tcp 25565" "$diretorioNgrok/ngrok.sh"
	echo -e "
COLE AQUI O LINK DA API DO BOT WEBHOOK DO DISCORD"
	read webh
    criarArq '#!/usr/bin/env sh
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