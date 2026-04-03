#!/bin/bash
source "$CONFIG_DIR/consts.sh"

CACHE_DIR="/tmp/sketchybar"
mkdir -p "$CACHE_DIR"

MAX_LEN=45

# Hide both items and exit early
hide_spotify() {
  sketchybar --set spotify.text drawing=off --set spotify.cover drawing=off
  exit 0
}

# Exit if Spotify isn't running
pgrep -x "Spotify" >/dev/null || hide_spotify

# Exit if not playing or paused
STATE=$(osascript -e 'tell application "Spotify" to player state as string' 2>/dev/null)
[[ "$STATE" != "playing" && "$STATE" != "paused" ]] && hide_spotify

# Fetch track info in a single osascript call
IFS='|' read -r TRACK ARTIST COVER_URL <<< "$(osascript \
  -e 'tell application "Spotify"' \
  -e 'set t to name of current track as string' \
  -e 'set a to artist of current track as string' \
  -e 'set u to artwork url of current track as string' \
  -e 'return t & "|" & a & "|" & u' \
  -e 'end tell' 2>/dev/null)"

# Podcasts may have no artist
[ -n "$ARTIST" ] && LABEL="$ARTIST - $TRACK" || LABEL="$TRACK"
[ ${#LABEL} -gt "$MAX_LEN" ] && LABEL="${LABEL:0:$(( MAX_LEN - 3 ))}..."

# Italic when playing, regular when paused
FONT_STYLE=$FONT_DEFAULT
[ "$STATE" = "playing" ] && FONT_STYLE=$FONT_ITALIC

# Fetch and cache cover art, keyed by URL hash to avoid re-downloading
COVER_IMAGE=""
COVER_DRAWING="off"
if [ -n "$COVER_URL" ]; then
  COVER_HASH=$(echo -n "$COVER_URL" | md5 -r | awk '{print $1}')
  COVER_PATH="$CACHE_DIR/cover_${COVER_HASH}.jpg"

  if [ ! -f "$COVER_PATH" ]; then
    # Download to a temp file first to avoid sketchybar reading a partial image
    TMP_PATH="$CACHE_DIR/cover_tmp_$$.jpg"
    if curl -s --max-time 5 "$COVER_URL" -o "$TMP_PATH" 2>/dev/null; then
      mv "$TMP_PATH" "$COVER_PATH"
    else
      rm -f "$TMP_PATH"
    fi
  fi

  if [ -f "$COVER_PATH" ]; then
    COVER_DRAWING="on"
    COVER_IMAGE="$COVER_PATH"
    # Clean up covers from previous tracks
    find "$CACHE_DIR" -name "cover_*.jpg" ! -name "cover_${COVER_HASH}.jpg" -delete
  fi
fi

sketchybar --animate tanh 20 \
  --set spotify.text label="$LABEL" label.font="$FONT_STYLE" drawing=on \
  --set spotify.cover background.image="$COVER_IMAGE" drawing="$COVER_DRAWING"