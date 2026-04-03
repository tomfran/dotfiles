#!/bin/bash

# Source colors
source "$CONFIG_DIR/consts.sh"

# Update all items using regex
sketchybar --set '/.*/' icon.color=$TEXT_COLOR label.color=$TEXT_COLOR
