#!/bin/bash

setupSteamDeckLike(){
        echo "SteamDeckLike
[1]Criar Sessão, [2]Remover Sessão"
    read resp
    case $resp in
		1)
            SESSION_NAME="SteamDeck-like"
            FILENAME="${SESSION_NAME}.desktop"
            EXEC_COMMAND="$mySteamDeckLike"
            SESSION_DIR="/usr/share/xsessions"
            sudo mkdir -p "$SESSION_DIR"
            cat <<EOF | sudo tee "${SESSION_DIR}/${FILENAME}"
[Desktop Entry]
Name=${SESSION_NAME}
Comment=Uma sessão de games com aparência de Steam Deck.
Exec=${EXEC_COMMAND}
Type=Application
EOF
            sudo chmod 644 "${SESSION_DIR}/${FILENAME}"
            echo "Arquivo de sessão criado com sucesso em: ${SESSION_DIR}/${FILENAME}"
            echo "A nova sessão '${SESSION_NAME}' agora está disponível no seu display manager.";;
        2)
            sudo rm $SESSION_DIR/$FILENAME
            echo "Arquivo de sessão removido com sucesso de: ${SESSION_DIR}";;
		*)
	esac

}