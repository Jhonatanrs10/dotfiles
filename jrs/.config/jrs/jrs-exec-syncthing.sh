#!/bin/bash

if pgrep -x "syncthing" >/dev/null; then
	dunstify -t 2000 --hints int:transient:1 "Syncthing" "Opening Page" --icon=syncthing
	xdg-open http://localhost:8384/ &
else
	dunstify -t 2000 --hints int:transient:1 "Syncthing" "Starting" --icon=syncthing
	syncthing --no-browser &
fi