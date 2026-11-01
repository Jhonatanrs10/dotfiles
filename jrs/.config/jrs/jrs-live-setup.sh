#!/bin/bash

#obs & pavucontrol & exit
exec_live_setup() {
	pavucontrol &
	flatpak run com.obsproject.Studio &
	xdg-open https://dashboard.twitch.tv/u/jardimrecreio/stream-manager &
}
