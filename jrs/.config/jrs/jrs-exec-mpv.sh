#!/bin/bash

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    LINK=$(wl-paste)
elif [ "$XDG_SESSION_TYPE" = "x11" ]; then
    LINK=$(xclip -o -selection clipboard)
else
	notify-send -i mpv "MPV" "XDG_SESSION_TYPE ?"
    exit 1
fi

if [ -n "$LINK" ]; then
    notify-send -i mpv "MPV" "Carregando:\n${LINK:0:45}..." && mpv --profile=low-1080p "$LINK"
else
    notify-send -i mpv "MPV" "Null"
fi