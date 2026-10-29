#!/usr/bin/env bash

pactl set-source-mute @DEFAULT_SOURCE@ toggle
IS_MUTED=$(pactl get-source-mute @DEFAULT_SOURCE@ | grep -q 'yes' && echo 'Mutado' || echo 'Ativo')

dunstify -h string:x-dunst-stack-tag:indicador "󰍭 Microfone" "$IS_MUTED"