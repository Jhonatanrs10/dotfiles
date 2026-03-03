#!/bin/bash

# DOCs
#https://github.com/ValveSoftware/gamescope/issues/1800
#MANGOHUD_CONFIG="read_cfg" MANGOHUD_CONFIGFILE="$HOME/.config/MangoHud/MangoHud.conf" gamescope --adaptive-sync --hdr-enabled -W 3840 -H 2160 -f --steam --mangoapp -- /usr/bin/steam -gamepadui

#https://github.com/shahnawazshahin/steam-using-gamescope-guide/wiki/Steam-using-Gamescope-guide-%E2%80%90-Wiki-page
#gamescope -e -- steam -steamdeck -steamos3

#ARCHWIKI
#steam gamescope mangohud gamemode

#GAMESCOPE
#--expose-wayland na nvidia causa bug na tela

#Arranque
#CS2
#WLR_XWAYLAND=/usr/bin/Xwayland gamescope -w 1024 -h 768 -W 1024 -H 768 -r 75 -S stretch -f --immediate-flips --rt --force-grab-cursor --mangoapp -- %command%

steamos-config() {
	sudo setcap 'CAP_SYS_NICE=eip' $(which gamescope)
	sudo tee /etc/modprobe.d/nvidia-modeset.conf <<<'options nvidia_drm modeset=1 fbdev=1'
	sudo usermod -aG gamemode $USER
}

steamos-setup() {
	packagesManager "$myBaseSteam $myBaseMangoHud $myBaseGamescope"
	SESSION_NAME="SteamOS"
	FILENAME="jrs-${SESSION_NAME}Mode.desktop"
	EXITFILENAME="jrs-${SESSION_NAME}Exit.sh"
	EXEC_COMMAND="sh -c 'gamescope -w 1600 -h 900 -W 1600 -H 900 -S stretch -f -C 5000 -e --cursor Adwaita --force-grab-cursor --mangoapp -- steam -steamdeck -steamos3'"
	APP_DIR="$HOME/.local/share/applications/jrs"
	SESSION_DIR="/usr/share/xsessions"
	#/usr/share/xsessions
	#/usr/share/wayland-sessions
	echo "SteamOSMode
[1] App, [2] Session, [3] Config"
	read resp
	case $resp in
	1) steamos-app ;;
	2) steamos-session ;;
	3) steamos-config ;;
	*) ;;
	esac
}

steamos-app() {
	echo "SteamOSMode
[1] Criar App, [2] Remover App"
	read resp
	case $resp in
	1)
		sudo mkdir -p "$APP_DIR"
		cat <<EOF | sudo tee "${APP_DIR}/${FILENAME}"
[Desktop Entry]
Name=${SESSION_NAME} Mode
Comment=Uma sessão de games com aparência de SteamOS.
Exec=${EXEC_COMMAND}
Icon=steam
Type=Application
Categories=Game;
EOF
		sudo chmod 777 "${APP_DIR}/${FILENAME}"
		;;
	2)
		sudo rm $APP_DIR/$FILENAME
		;;
	*) ;;
	esac
}

steamos-session() {
	echo "SteamOSMode
[1] Criar Sessão, [2] Remover Sessão"
	read resp
	case $resp in
	1)
		sudo mkdir -p "$SESSION_DIR"
		cat <<EOF | sudo tee "${SESSION_DIR}/${FILENAME}"
[Desktop Entry]
Name=${SESSION_NAME} Mode
Comment=Uma sessão de games com aparência de SteamOS.
Exec=${EXEC_COMMAND}
Icon=steam
Type=Application
Categories=Game;
EOF
		cat <<EOF | sudo tee "${APP_DIR}/${EXITFILENAME}"
#!/bin/bash
steam -shutdown
EOF
		sudo chmod 777 "${SESSION_DIR}/${FILENAME}"
		sudo chmod 777 "${APP_DIR}/${EXITFILENAME}"
		;;
	2)
		sudo rm $SESSION_DIR/$FILENAME
		sudo rm $APP_DIR/$EXITFILENAME
		;;
	*) ;;
	esac
}
