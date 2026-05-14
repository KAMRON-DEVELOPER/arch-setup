#!/usr/bin/env bash

# ~/.config/waypaper/post_command.sh
# This hook runs after waypaper changes the wallpaper

WALLPAPER="$1"

if [ -z "$WALLPAPER" ]; then
    echo "Error: No wallpaper path provided"
    exit 1
fi

echo "Generating colors from: $WALLPAPER"

# Run matugen to generate colors
matugen -v --show-colors --prefer darkness -m "dark" image "$WALLPAPER"


echo "Colors updated successfully!"
