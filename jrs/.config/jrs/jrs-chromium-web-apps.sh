#!/bin/bash

launch_chromium_web_app() {
	chromium --app=$1
}

launch_chromium_web_app_twitch() {
	echo "Twitch Name:"
	read twitch_name
	launch_chromium_web_app "https://player.twitch.tv/?channel=$twitch_name&enableExtensions=true&muted=true&parent=twitch.tv&player=popout&quality=720p60&volume=0.66"
	disown
	exit
}

