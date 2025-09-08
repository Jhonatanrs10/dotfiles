#!/bin/bash

# DOCs
#https://github.com/ValveSoftware/gamescope/issues/1800
#MANGOHUD_CONFIG="read_cfg" MANGOHUD_CONFIGFILE="$HOME/.config/MangoHud/MangoHud.conf" gamescope --adaptive-sync --hdr-enabled -W 3840 -H 2160 -f --steam --mangoapp -- /usr/bin/steam -gamepadui

#https://github.com/shahnawazshahin/steam-using-gamescope-guide/wiki/Steam-using-Gamescope-guide-%E2%80%90-Wiki-page
#gamescope -e -- steam -steamdeck -steamos3

#ARCHWIKI
#steam gamescope mangohud gamemode

#GAMESCOPE
#--expose-wayland na nvidia causa bug na tela

setupSteamDeckMode(){
    SESSION_NAME="SteamDeck"
    FILENAME="${SESSION_NAME}Mode.desktop"
    EXITFILENAME="${SESSION_NAME}Exit.sh"
    EXEC_COMMAND="gamescope -W 1600 -H 900 -w 1600 -h 900 -r 60 -f -C 5000 -e --force-grab-cursor --mangoapp -- steam -steamdeck -steamos3"
    APP_DIR="$HOME/.local/share/applications"
    XSESSION_DIR="/usr/share/xsessions"
    WSESSION_DIR="/usr/share/wayland-sessions"
    echo "SteamDeckMode
[1] Criar Sessão, [2] Remover Sessão, [3] Dependencias"
    read resp
    case $resp in
		1)
            sudo mkdir -p "$APP_DIR"
            sudo mkdir -p "$XSESSION_DIR"
            #sudo mkdir -p "$WSESSION_DIR"
            cat <<EOF | sudo tee "${APP_DIR}/${FILENAME}"
[Desktop Entry]
Name=${SESSION_NAME} Mode
Comment=Uma sessão de games com aparência de Steam Deck.
Exec=${EXEC_COMMAND}
Icon=steam
Type=Application
Categories=Game;
EOF
            cat <<EOF | sudo tee "${APP_DIR}/${EXITFILENAME}"
#!/bin/bash
steam -shutdown
EOF
            sudo chmod 777 "${APP_DIR}/${FILENAME}"
            sudo chmod 777 "${APP_DIR}/${EXITFILENAME}"
            sudo cp $APP_DIR/$FILENAME $XSESSION_DIR
            #sudo cp $APP_DIR/$FILENAME $WSESSION_DIR
            echo "A nova sessão '${SESSION_NAME}' agora está disponível no seu display manager.";;
        2)
            sudo rm $XSESSION_DIR/$FILENAME
            #sudo rm $WSESSION_DIR/$FILENAME
            sudo rm $APP_DIR/$FILENAME
            sudo rm $APP_DIR/$EXITFILENAME
            echo "Arquivos removidos.";;
        3)
            packagesManager "$myBaseSteamDeckMode";;
		*)
	esac

}