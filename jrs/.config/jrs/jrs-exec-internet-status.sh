#!/usr/bin/env bash

# Tenta pegar a rota padrão e a interface ativa
route_info=$(ip route show default 2>/dev/null)

if echo "$route_info" | grep -q 'dev wl'; then
    # É Wi-Fi
    wifi_ssid=$(nmcli -t -f active,ssid dev wifi 2>/dev/null | grep '^yes' | cut -d: -f2)
    [ -z "$wifi_ssid" ] && wifi_ssid=$(iwgetid -r 2>/dev/null)
    
    wifi_ip=$(ip -4 addr show 2>/dev/null | grep 'inet ' | grep -E 'wl' | awk '{print $2}' | cut -d/ -f1 | head -n 1)
    
    icon="󰖩"
    title="Wi-Fi"
    msg="Rede: ${wifi_ssid:-Conectado}\nIP: ${wifi_ip:-Sem IP}"

elif echo "$route_info" | grep -qE 'dev (en|eth|usb)'; then
    # É Cabo / Ethernet
    eth_ip=$(ip -4 addr show 2>/dev/null | grep 'inet ' | grep -E 'en|eth|usb' | awk '{print $2}' | cut -d/ -f1 | head -n 1)
    
    icon="󰈀"
    title="Cabeada (Ethernet)"
    msg="IP: ${eth_ip:-Sem IP}"

else
    icon="󰖪"
    title="Desconectado"
    msg="Sem rota ativa de internet"
fi

notify-send -u low -t 4000 -h string:x-dunst-stack-tag:info "$icon $title" "$msg"