#!/bin/bash

launch_chromium_web_app() {
	chromium --app=$1
}

launch_chromium_web_app_youtube() {
	launch_chromium_web_app "https://www.youtube.com/feed/subscriptions"
}

launch_chromium_web_app_crunchyroll(){
	launch_chromium_web_app "https://www.crunchyroll.com/videos/new"
}