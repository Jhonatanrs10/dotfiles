#!/bin/bash

picom-stop() {
  killall picom
  dunstify -t 2000 --hints int:transient:1 "Picom" "Stopped" --icon=picom
}

picom-start() {
  picom &
  dunstify -t 2000 --hints int:transient:1 "Picom" "Started" --icon=picom
}

profile-performance() {
  powerprofilesctl set performance
  dunstify -t 2000 --hints int:transient:1 "Power Profile" "Performance" --icon=xfce4-cpugraph-plugin
}

profile-balanced() {
  powerprofilesctl set balanced
  dunstify -t 2000 --hints int:transient:1 "Power Profile" "Balanced" --icon=xfce4-cpugraph-plugin
}

profile-power-saver() {
  powerprofilesctl set power-saver
  dunstify -t 2000 --hints int:transient:1 "Power Profile" "Power Saver" --icon=xfce4-cpugraph-plugin
}
