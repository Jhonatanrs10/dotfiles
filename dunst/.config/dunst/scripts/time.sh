#!/usr/bin/env bash

# Notificação de Data e Hora com Dunstify
dunstify -u low \
         -t 3000 \
         -h string:x-dunst-stack-tag:info \
         "󰃭 $(date '+%A, %d de %B')" \
         "󰥔 $(date '+%H:%M:%S')"