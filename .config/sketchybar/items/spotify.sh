#!/bin/bash

sketchybar --add event spotify_change com.spotify.client.PlaybackStateChanged

spotify_text=(
	icon.drawing=off
	icon.padding_left=0
	icon.padding_right=0
	label.drawing=on
	padding_right=10
	padding_left=0
	click_script="open -a Spotify"
	script="$PLUGIN_DIR/spotify.sh"
	updates=when_shown
)

spotify_cover=(
	icon.drawing=off
	label.drawing=off
	background.image.scale=0.04
	background.image.drawing=on
	background.drawing=on
	background.color=0x00000000
	width=30
	padding_left=5
	padding_right=5
	click_script="open -a Spotify"
	script="$PLUGIN_DIR/spotify.sh"
	updates=when_shown
)

sketchybar --add item spotify.text right \
	--set spotify.text "${spotify_text[@]}" \
	--subscribe spotify.text spotify_change system_woke \
	\
	--add item spotify.cover right \
	--set spotify.cover "${spotify_cover[@]}" \
	--subscribe spotify.cover spotify_change system_woke
