#!/usr/bin/env bash

pactl set-sink-volume @DEFAULT_SINK@ -5%
VOL=$(pamixer --get-volume 2>/dev/null || pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -n 1 | tr -d '%')

dunstify -h string:x-dunst-stack-tag:indicador \
         -h int:value:"$VOL" \
         "󰖀 Volume"