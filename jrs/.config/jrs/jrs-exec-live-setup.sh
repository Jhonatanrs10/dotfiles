#!/bin/bash

#obs & pavucontrol & exit
pavucontrol &
flatpak run com.obsproject.Studio &
xdg-open https://dashboard.twitch.tv/u/jardimrecreio/stream-manager &
exit