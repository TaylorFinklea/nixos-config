#!/bin/sh
sketchybar --add item clock-eastern right                            \
           --set clock-eastern script="$PLUGIN_DIR/clock-eastern.sh" padding_right=5 background.drawing=1 icon.background.drawing=1 icon.color=$COLOR_BACKGROUND icon.padding_left=4 icon.padding_right=5 label.padding_left=1 label.padding_right=5 background.color=$COLOR_BACKGROUND label.font.size=12.5 label.color=$COLOR_CYAN update_freq=1 label.font.style="Bold"
