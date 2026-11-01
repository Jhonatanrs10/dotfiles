#!/bin/bash

exec_discord() {
	if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
		OZONE_HINT="wayland"
	else
		OZONE_HINT="x11"
	fi

	if flatpak info com.discordapp.Discord &>/dev/null; then
		env ELECTRON_OZONE_PLATFORM_HINT="$OZONE_HINT" flatpak run com.discordapp.Discord --no-sandbox &
		dunstify -t 2000 --hints int:transient:1 "Discord" "flatpak" --icon=discord
	elif command -v discord &>/dev/null; then
		env ELECTRON_OZONE_PLATFORM_HINT="$OZONE_HINT" discord --no-sandbox &
		dunstify -t 2000 --hints int:transient:1 "Discord" "pacman" --icon=discord
	else
		dunstify -t 2000 --hints int:transient:1 "Discord" "Nenhuma versão encontrada!" --icon=discord
	fi
}
