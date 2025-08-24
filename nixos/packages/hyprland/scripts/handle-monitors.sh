#!/bin/bash

# Get the current monitor setup
MONITORS=$(hyprctl monitors -j | jq length)

# Apply workspace configuration based on number of monitors
if [ "$MONITORS" -eq 1 ]; then
    # Just laptop screen
    for i in {1..9}; do
        hyprctl dispatch workspace "$i" eDP-1
    done
elif [ "$MONITORS" -eq 2 ]; then
    # Laptop + one external
    for i in {1..3}; do
        hyprctl dispatch workspace "$i" eDP-1
    done
    for i in {4..6}; do
        hyprctl dispatch workspace "$i" DP-1
    done
    for i in {7..9}; do
        hyprctl dispatch workspace "$i" DP-1
    done
elif [ "$MONITORS" -ge 3 ]; then
    # Laptop + two externals
    for i in {1..3}; do
        hyprctl dispatch workspace "$i" eDP-1
    done
    for i in {4..6}; do
        hyprctl dispatch workspace "$i" DP-1
    done
    for i in {7..9}; do
        hyprctl dispatch workspace "$i" HDMI-A-2
    done
fi
