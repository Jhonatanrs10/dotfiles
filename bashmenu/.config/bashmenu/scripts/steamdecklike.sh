#!/bin/bash

setupSteamDeckLike(){
    SESSION_NAME="SteamDeck-like"
    FILENAME="${SESSION_NAME}.desktop"
    EXEC_COMMAND="exec /home/$USER/.config/jrs/steamdecklike.sh"
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
    echo "A nova sessão '${SESSION_NAME}' agora está disponível no seu display manager."
}