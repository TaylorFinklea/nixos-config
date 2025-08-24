#!/usr/bin/env bash
# ~/.config/scripts/wallpaper.sh

# TODO: add support for multiple monitors with their own wallpapers
# TODO: add support for my own wallpapers

# Directory setup
WALLPAPER_DIR="$HOME/.local/share/wallpapers"
CURRENT_WALLPAPER="$WALLPAPER_DIR/current.jpg"
LOCK_WALLPAPER="$WALLPAPER_DIR/lock.jpg"

# Create directory if it doesn't exist
mkdir -p "$WALLPAPER_DIR"

# Unsplash API key
UNSPLASH_ACCESS_KEY="syfAGPWN0BN4TqV_whpcj7JQFOZ4s-yJbjNoMm1Bfs0"

# Animation settings
TRANSITION_TYPE="grow"
TRANSITION_FPS=60
TRANSITION_DURATION=5
TRANSITION_STEP=255
TRANSITION_ANGLE=30
TRANSITION_POS=$(hyprctl cursorpos)

# Function to check internet connectivity
check_internet() {
    wget -q --spider http://google.com
    return $?
}

# Fetch new wallpaper with retry
fetch_wallpaper() {
    echo "Attempting to fetch new wallpaper..."
    local max_attempts=10
    local attempt=1
    local wait_time=5

    while [ $attempt -le $max_attempts ]; do
        if check_internet; then
            echo "Internet connection available, fetching wallpaper..."
            if curl -L "https://api.unsplash.com/photos/random?query=nature&orientation=landscape&client_id=$UNSPLASH_ACCESS_KEY" | \
               jq -r '.urls.full' | \
               xargs curl -L -o "$CURRENT_WALLPAPER"; then

                # Create blurred version for lock screen
                if magick convert "$CURRENT_WALLPAPER" -blur 0x8 "$LOCK_WALLPAPER"; then
                    echo "Wallpaper successfully downloaded and processed"
                    return 0
                fi
            fi
        fi

        echo "Attempt $attempt failed. Waiting $wait_time seconds before retry..."
        sleep $wait_time
        attempt=$((attempt + 1))
        wait_time=$((wait_time * 2))  # Exponential backoff
    done

    echo "Failed to fetch wallpaper after $max_attempts attempts"
    return 1
}

# Set wallpaper with animation
set_wallpaper() {
    echo "Setting wallpaper with animation..."
    swww img "$CURRENT_WALLPAPER" \
        --transition-type "$TRANSITION_TYPE" \
        --transition-fps "$TRANSITION_FPS" \
        --transition-duration "$TRANSITION_DURATION" \
        --transition-pos "$TRANSITION_POS" \
        --transition-step "$TRANSITION_STEP" \
        --transition-angle "$TRANSITION_ANGLE"
}

# Main execution
fetch_wallpaper && set_wallpaper
