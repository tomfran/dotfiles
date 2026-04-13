#!/bin/bash

FONT_DEFAULT="SF Mono:Medium:15.5"
FONT_ITALIC="SF Mono:Medium Italic:15.5"

export WHITE=0xffffffff
export BLACK=0xff000000
export DARK_TEXT=$WHITE
export LIGHT_TEXT=$WHITE
export TRANSPARENT_TEXT=0x00ffffff

APPEARANCE=$(defaults read -g AppleInterfaceStyle 2>/dev/null)

if [ "$APPEARANCE" = "Dark" ]; then
	export TEXT_COLOR=$LIGHT_TEXT
else
	export TEXT_COLOR=$DARK_TEXT
fi

export BAR_COLOR=0x00000000
export ITEM_BG_COLOR=0x00000000
