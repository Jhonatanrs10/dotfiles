#!/usr/bin/env bash

dunstify -u low \
         -t 5000 \
         -h string:x-dunst-stack-tag:info \
         "󰖐 Clima" "$(curl -s 'wttr.in/?format=1' || echo 'Sem conexão')"