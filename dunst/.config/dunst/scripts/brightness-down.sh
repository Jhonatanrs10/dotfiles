#!/usr/bin/env bash

brightnessctl set 5%-
CURR=$(brightnessctl get)
MAX=$(brightnessctl max)
PERCENT=$(( CURR * 100 / MAX ))

dunstify -h string:x-dunst-stack-tag:indicador \
         -h int:value:"$PERCENT" \
         "󰃠 Brilho"