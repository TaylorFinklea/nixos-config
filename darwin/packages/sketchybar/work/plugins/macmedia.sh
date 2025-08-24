#!/usr/bin/env bash
STATE=$(osascript -e 'tell app "Music" to player state as string')
if [[ "$STATE" == "playing" ]]; then
  TITLE=$(osascript -e 'tell app "Music" to name of current track')
  ARTIST=$(osascript -e 'tell app "Music" to artist of current track')
  sketchybar --set "$NAME" label="$TITLE — $ARTIST"
else
  sketchybar --set "$NAME" label=""
fi
