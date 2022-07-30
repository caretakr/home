#!/bin/sh

#
# Wallpaper startup
#

_WALLPAPER="$HOME/.wallpapers/michael-benz-IgWNxx7paz4-unsplash.jpg"

if [ -f "$_WALLPAPER" ]; then
    feh --bg-fill "$_WALLPAPER"
fi

