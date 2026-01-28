#!/bin/bash

mkdir -p $HOME/.local/share/applications/jrs
echo -e "[Desktop Entry]
Version=1.0
Type=Application
Name=Rofi(jrs)
GenericName=jrs
Categories=jrs;
Comment=My Rofi
Exec=bash jrs-rofi.sh
Icon=rofi
Path=$HOME/.config/jrs
Terminal=false" >$HOME/.local/share/applications/jrs/jrs-rofi.desktop