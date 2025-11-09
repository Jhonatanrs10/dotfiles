#!/usr/bin/env sh
#https://developer.valvesoftware.com/wiki/SteamCMD#Linux
#essa linha corrige possiveis erros restaurando as configuracoes padrao do SteamCMD validando-as
#bash ./steamcmd.sh +login anonymous +app_update 1110390 validate +quit

serversLinuxUser() {
    if id "$linuxUserServer" &>/dev/null; then
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

installSteamCMD(){
    echo "USAR YAY"
    sleep 2
    packagesManager "steamcmd"
}

installFivem(){
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
	criaDiretorio "diretorioServer" "$dBashMenu/$fivemNome"
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

	criarArq "#!/usr/bin/env sh
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

installMinecraftServer(){
	uninstallPastaAtalhoBinMesmoNome "MinecraftServer"
	link="https://piston-data.mojang.com/v1/objects/4707d00eb834b446575d89a61a11b5d548d8c001/server.jar"

	echo -e "[INFO] - CRIANDO DIRETORIOS... - [INFO]"
	criaDiretorioInstall "$dBashMenu/MinecraftServer"

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

sampServer(){

    installName="SampServer"
    uninstallPastaAtalhoBinMesmoNome "$installName"
    criaDiretorioInstall "$dBashMenu/$installName"


    criaPastaBaixaExtrai "$diretorioInstall" "http://files.sa-mp.com/samp037svr_R2-1.tar.gz" "samp.tar.gz"
    mv */* .

    criarArq "#!/usr/bin/env sh
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

terrariaServer(){
    installName="TerrariaServer"
    uninstallPastaAtalhoBinMesmoNome "$installName"
    criaDiretorioInstall "$dBashMenu/$installName"
    criaPastaBaixaExtrai "$diretorioInstall" "https://terraria.org/api/download/pc-dedicated-server/terraria-server-1449.zip" "ts.zip"
    chmod 770 $diretorioInstall/*/Linux/TerrariaServer.bin.x86_64
    criaArqRunDiretorioInstall "#!/usr/bin/env sh
cd $diretorioInstall/*/Linux
./TerrariaServer.bin.x86_64"
    criaAtalho "$installName" "Terraria Server PC" "bash run.sh" "$diretorioInstall" "true" "$installName" "application-default-icon"
    criaAtalhoBin "$diretorioInstall/run.sh" "$installName"
}   

installUnturnedServer(){
    #cria e loga no usuario steam
    #criaLogaUserSteam

    installName="UnturnedServer"
    uninstallPastaAtalhoBinMesmoNome "$installName"
    criaDiretorioInstall "$dBashMenu/$installName"

    aptSteamCMD(){
        #dependencias
        sudo add-apt-repository multiverse
        sudo apt install software-properties-common
        sudo dpkg --add-architecture i386
        sudo apt update
        #instalando SteamCMD
        sudo apt install lib32gcc-s1 steamcmd
        #baixando dependencias
        steamcmd +login anonymous +app_update 1110390 +quit
    }
    
    manuallySteamCMD(){
        packagesManager "lib32gcc-s1"
        criaPastaBaixaExtrai "$diretorioInstall" "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" "steamcmd.tar.gz"
        #baixando dependencias
        bash ./steamcmd.sh +login anonymous +app_update 1110390 +quit
        packagesManager "tmux screen"
    }
    
    criarArq "Map Ex.(PEI - Germany - Russia - Washington) 
help no console do server para ver comandos
edite o local/diretorio do server em run.sh
mova ou copie o arquivo commands.dat para:
Steam/steamapps/common/U3DS/Servers/JardimRecreio/Server/Commands.dat " "LEIAME.txt"

    criarArq "Name JardimRecreio
Map PEI
Maxplayers 10
Port 27015
perspective both
mode normal
pve
welcome Bem Vindo ao bairro!!
cheats on" "Commands.dat"

    menu12345 "[1]APT [2]MANUALLY" "aptSteamCMD" "manuallySteamCMD"

    criarArq "#!/usr/bin/env sh
bash $diretorioInstall/steamcmd.sh +login anonymous +app_update 1110390 +quit
cd $HOME/Steam/steamapps/common/U3DS
bash ServerHelper.sh +LanServer/JardimRecreio" "$diretorioInstall/run.sh"

    #criaAtalho "$installName" "Description" "bash run.sh" "$diretorioInstall" "false" "$installName" "$dBashMenu/Icons/default.svg"
    criaAtalhoBin "$diretorioInstall/run.sh" "$installName"

}   

installProjectZomboidServer(){
    installName="PZserver"
    uninstallPastaAtalhoBinMesmoNome "$installName"
    criaDiretorioInstall "$dBashMenu/$installName"
    installSteamCMD

    criarArq "// update_zomboid.txt
//
@ShutdownOnFailedCommand 1 //set to 0 if updating multiple servers at once
@NoPromptForPassword 1
force_install_dir $diretorioInstall
//for servers which don't need a login
login anonymous
app_update 380870 validate
quit" "$diretorioInstall/update_zomboid.txt"

criarArq "export PATH=$PATH:/usr/games
steamcmd +runscript $HOME/update_zomboid.txt" "run.sh"
#criaAtalhoBin "$diretorioInstall/run.sh" "$installName"

}   