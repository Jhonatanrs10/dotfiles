#!/bin/bash

source $HOME/.config/jrs/jrs-scripts-power.sh

clear
echo "[1] Shutdown
[2] Restart
[3] Suspend
[4] Hibernate
[5] Logout
[6] Exit WM"

read chosen

case "$chosen" in
1) shutdown-wm ;;
2) restart-wm ;;
3) systemctl suspend ;;
4) systemctl hibernate ;;
5) pkill -KILL -u $USER ;;
6) exit-wm ;;
*) exit 1 ;;
esac
