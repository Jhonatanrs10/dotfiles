#!/usr/bin/env bash

brightnessctl set 5%- && 
dunstify -h string:x-dunst-stack-tag:indicador -h int:value:"$(( 105 - ($(brightnessctl get) * 105 / $(brightnessctl max)) ))" "󰃠 Brilho"
