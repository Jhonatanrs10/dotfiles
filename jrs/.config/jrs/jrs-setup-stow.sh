#!/bin/bash

# Caminhos (ajuste se necessário)
DOTFILES_DIR="$HOME/.dotfiles"
CONFIG_DIR="$HOME/.config"
BKP_DIR="$HOME/.config/bkp_config"

# Garante que a pasta de backup existe
mkdir -p "$BKP_DIR"

echo "--- Iniciando Backup Baseado em Dotfiles ---"

# Entra na pasta de dotfiles para listar o que tem lá
cd "$DOTFILES_DIR" || exit

# Loop apenas pelas pastas (*/) dentro de .dotfiles
for folder in */; do
    # Remove a barra '/' do final do nome da pasta
    folder=${folder%/}

    # Verifica se essa pasta também existe no seu ~/.config
    if [ -d "$CONFIG_DIR/$folder" ]; then
        echo "Backup de: $folder..."
        
        # Copia de ~/.config para a pasta de backup
        # -a: preserva atributos (links, permissões, etc)
        # -v: verbose (mostra o que está sendo feito)
        cp -av "$CONFIG_DIR/$folder" "$BKP_DIR/"
    else
        echo "Aviso: '$folder' existe em dotfiles, mas não em $CONFIG_DIR. Pulando..."
    fi
done

echo "--- Processo concluído! ---"