#!/usr/bin/env bash

BAT_CAP=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null || echo 'N/A')
BAT_STAT=$(cat /sys/class/power_supply/BAT*/status 2>/dev/null || echo 'N/A')
PROFILE=$(powerprofilesctl get 2>/dev/null || echo 'N/A')

dunstify -u low \
         -t 3000 \
         -h string:x-dunst-stack-tag:info \
         "󰚥 Status de Energia" \
         "󰁹 ${BAT_CAP}% (${BAT_STAT})\n󰓅 Perfil: ${PROFILE}"