#!/bin/sh
source "$HOME/.config/sketchybar/icons.sh" # Loads all defined icons

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected
sketchybar --set $NAME background.drawing=$SELECTED \
    icon.highlight=$SELECTED \
    label.highlight=$SELECTED

if [[ $SENDER == "front_app_switched" ]];
then
    # Get the number of spaces from AeroSpace
    SPACE_COUNT=$(aerospace list-workspaces --all | wc -l)

    for ((sid=1; sid<=$SPACE_COUNT; sid++))
    do
        # Start the label with the space number
        LABEL="$sid: "

        # Query windows in the current space using AeroSpace
        QUERY=$(aerospace list-windows --workspace-id $sid)

        if [[ ! -z "$QUERY" ]]; then
            # Parse the window information
            while IFS='|' read -r APP_NAME WINDOW_TITLE _; do
                if [[ ! -z "$APP_NAME" ]]; then
                    ICON=$($HOME/.config/sketchybar/plugins/app_icon.sh "$APP_NAME" "$WINDOW_TITLE")
                    if [[ ! -z "$LABEL" && $LABEL != "$sid: " ]]; then
                        LABEL+=" "
                    fi
                    LABEL+=$ICON
                fi
            done <<< "$QUERY"
        else
            LABEL+="_"
        fi

        # Check if this workspace is focused
        IS_FOCUSED=$(aerospace list-workspaces --all | awk -v sid="$sid" '$1 == sid && $3 == "true" {print "true"}')
        if [[ $IS_FOCUSED == "true" ]]; then
            sketchybar --set space.$sid background.drawing=on
        else
            sketchybar --set space.$sid background.drawing=off
        fi

        sketchybar --set space.$sid label="$LABEL"
    done
fi
