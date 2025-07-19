#!/usr/bin/env bash

profiles="performance\nbalanced\npower-saver"
selected_profile=$(echo -e $profiles | rofi -dmenu -p "Select Power Profile")

if [ -n "$selected_profile" ]; then
    powerprofilesctl set "$selected_profile"
fi
