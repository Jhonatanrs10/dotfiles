#!/bin/bash

# Nome do processo do hyprpaper
PROCESS_NAME="hyprpaper"

echo "--- Reiniciando Hyprpaper ---"

# 1. Fechar o Hyprpaper (se estiver rodando)
echo "Tentando fechar instâncias existentes de $PROCESS_NAME..."
pkill $PROCESS_NAME

# Verificar se o processo foi fechado e esperar um pouco
if [ $? -eq 0 ]; then
	echo "$PROCESS_NAME fechado com sucesso. Aguardando 1 segundo..."
	dunstify -t 1500 --hints int:transient:1 "Hyprpaper" "Restarting" --icon=lximage
	sleep 1
else
	echo "Nenhuma instância de $PROCESS_NAME foi encontrada ou houve um erro ao fechar."
fi

# 2. Abrir o Hyprpaper
echo "Iniciando $PROCESS_NAME..."
# O & é crucial para rodar o hyprpaper em background
# e liberar o seu terminal.
$PROCESS_NAME &

if [ $? -eq 0 ]; then
	echo "✅ $PROCESS_NAME iniciado com sucesso em background."
else
	echo "❌ Erro ao iniciar $PROCESS_NAME."
fi

echo "------------------------------"
