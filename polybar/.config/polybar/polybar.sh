#!/bin/bash

cat <<EOF | xrdb -merge
Xcursor.theme: Adwaita
Xcursor.size: 24
EOF

## 1. Limpeza
# Encerra instâncias de barra já em execução (quiet mode)
killall -q polybar

# Aguarda até que os processos sejam encerrados (máximo de 2 segundos)
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

## 2. Inicialização em Múltiplos Monitores
# Verifica se há mais de um monitor e inicia uma instância para cada um
for m in $(polybar --list-monitors | cut -d":" -f1); do
    # Exporta o nome do monitor e carrega a barra 'i3' para ele
    MONITOR=$m polybar --reload jrs &
done

echo "Polybar iniciado em todos os monitores."