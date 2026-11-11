#!/bin/bash

launch_chromium_web_app() {
	chromium --app=$1 &
}

launch_chromium_web_app_twitch() {
	echo "Twitch Name:"
	read twitch_name
	chromium --app="https://player.twitch.tv/?channel=$twitch_name&enableExtensions=true&muted=true&parent=twitch.tv&player=popout&quality=720p60&volume=0.66" &
	exit 1
}

launch_chromium_web_app_twitch_chat() {
	echo "Twitch name:"
	read twitchName
	chromium --app="https://www.twitch.tv/popout/$twitchName/chat?popout=" &
	exit 1
}

