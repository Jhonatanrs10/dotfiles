#!/bin/bash

# 1. Verifica e instala automaticamente as dependências se faltarem (--needed)
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    if ! pacman -Qe wl-clipboard &>/dev/null; then
        echo "Instalando wl-clipboard..."
        sudo pacman -S --needed --noconfirm wl-clipboard
    fi
elif [ "$XDG_SESSION_TYPE" = "x11" ]; then
    if ! pacman -Qe xclip &>/dev/null; then
        echo "Instalando xclip..."
        sudo pacman -S --needed --noconfirm xclip
    fi
fi

# 2. Pega o link da área de transferência dependendo da sessão atual
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    LINK=$(wl-paste)
elif [ "$XDG_SESSION_TYPE" = "x11" ]; then
    LINK=$(xclip -out -selection clipboard)
else
    echo "Erro: Não foi possível detectar se você está no Xorg ou Wayland."
    exit 1
fi

# 3. Executa o mpv se houver algo na área de transferência
if [ -n "$LINK" ]; then
    echo "Sessão detectada: $XDG_SESSION_TYPE"
    echo "Abrindo: $LINK"
    mpv "$LINK"
else
    echo "A área de transferência está vazia ou não contém texto."
fi