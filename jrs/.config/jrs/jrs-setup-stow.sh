#!/bin/bash

# Definição dos caminhos
DOTFILES_DIR="$HOME/.dotfiles"
CONFIG_DIR="$HOME/.config"
BKP_DIR="$HOME/.config/dotfiles_bkp"

# Garante que a pasta de backup existe
mkdir -p "$BKP_DIR"

echo "--- Iniciando Movimentação para Backup ---"

# Entra na pasta de dotfiles para listar o que você já gerencia
cd "$DOTFILES_DIR" || { echo "Erro: Pasta $DOTFILES_DIR não encontrada."; exit 1; }

# Loop apenas pelas pastas (*/) dentro de .dotfiles
for folder in */; do
    # Remove a barra '/' do final do nome da pasta (ex: 'nvim/' vira 'nvim')
    folder=${folder%/}

    # Verifica se essa pasta existe no seu ~/.config
    if [ -d "$CONFIG_DIR/$folder" ]; then
        echo "Movendo: $CONFIG_DIR/$folder  ->  $BKP_DIR/"
        # O comando de mover propriamente dito
        mv "$CONFIG_DIR/$folder" "$BKP_DIR/"
    else
        echo "Pulando: '$folder' (não encontrada em $CONFIG_DIR)"
    fi
done

cd $DOTFILES_DIR
stow */
bash $HOME/.config/jrs/jrs-setup-bash.sh
rm $HOME/.config/hypr/colors.conf
bash $HOME/.config/jrs/jrs-rofi-set-theme.sh
echo "--- Processo concluído! ---"