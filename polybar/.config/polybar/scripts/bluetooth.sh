#!/bin/sh
if [ $(bluetoothctl show | grep "Powered: yes" | wc -l) -gt 0 ]; then
  if [ $(bluetoothctl info | grep "Device" | wc -l) -gt 0 ]; then
    echo " 󰂱 " # Blue icon when connected
  else
    echo "  " # White icon when on but disconnected
  fi
else
  echo "" # Dimmed icon when off
fi