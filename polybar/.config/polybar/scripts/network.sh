#!/bin/sh

# Verifica Ethernet (Cabo)
# Procura por qualquer interface que comece com 'e' (enp..., eth...) e esteja 'up'
ETH_STATUS=$(cat /sys/class/net/e*/operstate 2>/dev/null)

if [ "$ETH_STATUS" = "up" ]; then
    echo " 󰀂 "
    exit 0
fi

# Se não houver cabo, verifica o Wi-Fi via nmcli
WIFI_STATUS=$(nmcli radio wifi)

if [ "$WIFI_STATUS" = "enabled" ]; then
    SSID=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
    
    if [ -n "$SSID" ]; then
        echo "  "
    else
        echo " 󰤮 "
    fi
else
    echo " 󰤭 "
fi