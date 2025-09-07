#!/bin/bash

setupSteamDeckLike(){
    SESSION_NAME="SteamDecklike"
    FILENAME="${SESSION_NAME}.desktop"
    EXEC_COMMAND="gamescope -W 1600 -H 900 -w 1600 -h 900 -r 60 -f -C 5000 -e --force-grab-cursor --mangoapp -- steam -steamdeck -steamos3"
    XSESSION_DIR="/usr/share/xsessions"
    WSESSION_DIR="/usr/share/wayland-sessions"
    APP_DIR="$HOME/.local/share/applications"
    echo "SteamDeckLike
[1]Criar Sessão, [2]Remover Sessão"
    read resp
    case $resp in
		1)
            
            sudo mkdir -p "$XSESSION_DIR"
            sudo mkdir -p "$WSESSION_DIR"
            sudo mkdir -p "$APP_DIR"
            cat <<EOF | sudo tee "${XSESSION_DIR}/${FILENAME}"
[Desktop Entry]
Name=${SESSION_NAME}
Comment=Uma sessão de games com aparência de Steam Deck.
Exec=${EXEC_COMMAND}
Icon=steam
Type=Application
Categories=Game;
EOF
            sudo chmod 644 "${APP_DIR}/${FILENAME}"
            sudo cp $APP_DIR/$FILENAME $XSESSION_DIR
            sudo cp $APP_DIR/$FILENAME $WSESSION_DIR
            echo "A nova sessão '${SESSION_NAME}' agora está disponível no seu display manager.";;
        2)
            sudo rm $XSESSION_DIR/$FILENAME
            sudo rm $WSESSION_DIR/$FILENAME
            sudo rm $APP_DIR/$FILENAME
            echo "Arquivos removidos.";;
		*)
	esac

}