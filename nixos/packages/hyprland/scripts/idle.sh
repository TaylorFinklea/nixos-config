#!/usr/bin/env bash
swayidle -w \
    timeout 30 'hyprctl dispatch dpms off' \
    resume 'hyprctl dispatch dpms on' \
    timeout 20 'swaylock --clock --screenshots --effect-blur 7x5 --effect-vignette 0.5:0.5 --grace 2 --ring-color 18cae6 --key-hl-color a220ea --inside-color 1e1e2e --separator-color 494d64 --indicator --indicator-radius 100 --indicator-thickness 7 --fade-in 0.2' \
    before-sleep 'swaylock --clock --screenshots --effect-blur 7x5 --effect-vignette 0.5:0.5 --grace 2 --ring-color 18cae6 --key-hl-color a220ea --inside-color 1e1e2e --separator-color 494d64 --indicator --indicator-radius 100 --indicator-thickness 7 --fade-in 0.2' \
    after-resume 'pkill waybar; waybar & disown'
