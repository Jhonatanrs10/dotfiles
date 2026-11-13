#!/usr/bin/env bash

pactl set-sink-mute @DEFAULT_SINK@ toggle
IS_MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -q 'yes' && echo 'Mutado' || echo 'Ativo')

dunstify -h string:x-dunst-stack-tag:indicador "󰕾 Volume" "$IS_MUTED"