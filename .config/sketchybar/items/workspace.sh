#!/bin/bash

workspace=(
	label="?"
	icon.drawing=off
	padding_left=0
	padding_right=0
	label.width=20
	script="$PLUGIN_DIR/workspace.sh"
)

sketchybar --add item workspace left \
	--set workspace "${workspace[@]}" \
	--subscribe workspace aerospace_workspace_change
