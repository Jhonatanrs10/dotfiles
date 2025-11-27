#!/usr/bin/env sh
dependenciasAtalho(){
    echo "INSTALAR ATALHO 
Diretório atual:
$PWD
Este é o diretório do $nomeRun.sh (s/n)"
    read resp
    if [ "$resp" = "s" ]; then
        wrapper="$JRS_DIR/.jrs.sh"

        echo "Criando wrapper em: $wrapper"

        cat <<EOF > "$wrapper"
#!/usr/bin/env bash
cd "$PWD"
bash "$nomeRun.sh"
EOF

        chmod +x "$wrapper"
        sudo ln -sf "$wrapper" /usr/bin/jrs

        echo "Atalho 'jrs' criado! Agora você pode rodar o script de qualquer lugar com:"
        echo -e "  ${GREEN}jrs${RESET}"
    fi
}

dependencies() {
    local wrapper="$JRS_DIR/.jrs.sh"
    local link_name="jrs"
    local link_path="/usr/bin/$link_name"

    # Verifica se o arquivo wrapper já existe
    if [ ! -f "$wrapper" ]; then
        echo "O atalho '$link_name' não existe. Criando agora..."
        
        # Cria o diretório se ele não existir
        mkdir -p "$(dirname "$wrapper")"

        # Cria o arquivo wrapper
        cat <<EOF > "$wrapper"
#!/usr/bin/env bash
cd "$PWD"
bash "$nomeRun.sh"
EOF

        # Torna o arquivo executável
        chmod +x "$wrapper"
        echo "Arquivo wrapper criado em: $wrapper"
    fi

    # Verifica se o link simbólico existe e o cria se não
    if [ ! -L "$link_path" ]; then
        echo "O link simbólico para '$link_name' não existe. Criando agora..."
        sudo ln -sf "$wrapper" "$link_path"
        echo "Atalho '$link_name' criado com sucesso!"
    else
        echo "Atalho '$link_name' já está instalado."
        
    fi
    sleep 0
}
