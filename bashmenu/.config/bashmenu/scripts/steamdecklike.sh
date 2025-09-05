#!/bin/bash

setupSteamDeckLike(){
    # --- Variáveis de Configuração ---
    # Nome da sua sessão, como aparecerá no gerenciador de login.
    SESSION_NAME="SteamDeck-like"

    # Nome do arquivo .desktop
    FILENAME="${SESSION_NAME}.desktop" # Remove espaços para o nome do arquivo

    # Comando que será executado para iniciar a sessão.
    # Usa a variável $USER para garantir o caminho correto para o diretório home.
    # O 'exec' é crucial para substituir o shell pelo novo processo.
    EXEC_COMMAND="exec /home/$USER/.config/jrs/steamdecklike.sh"

    # Caminho para salvar o arquivo de sessão.
    SESSION_DIR="/usr/share/xsessions"

    # --- Validação ---

    # Verifica se o script está sendo executado como root.
    if [ "$(id -u)" -ne 0 ]; then
    echo "Este script precisa ser executado como root. Use 'sudo'."
    fi

    # Cria o diretório de sessões se ele não existir.
    sudo mkdir -p "$SESSION_DIR"

    # --- Criação do Arquivo .desktop ---

    sudo cat > "${SESSION_DIR}/${FILENAME}" <<EOF
[Desktop Entry]
Name=${SESSION_NAME}
Comment=Uma sessão de games com aparência de Steam Deck.
Exec=${EXEC_COMMAND}
Type=Application
EOF

    # --- Finalização ---

    # Define as permissões corretas para o arquivo.
    sudo chmod 644 "${SESSION_DIR}/${FILENAME}"

    echo "Arquivo de sessão criado com sucesso em: ${SESSION_DIR}/${FILENAME}"
    echo "A nova sessão '${SESSION_NAME}' agora está disponível no seu display manager."
}