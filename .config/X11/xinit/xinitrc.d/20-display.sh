#!/bin/sh

#
# Display startup
#

_CONNECTED=$(xrandr -q | awk '/ connected/ {count++} END {print count}')
_PRIMARY=$(xrandr -q | awk '/ connected/ {print $1}' | sed -sn 1p)

if [ "$_CONNECTED" = 1 ]; then
  xrandr \
    --output "$_PRIMARY" --primary --mode 1920x1200 --rate 59.95 --pos 0x0
elif [ "$_CONNECTED" = 2 ]; then
  _SECONDARY=$(xrandr -q | awk '/ connected/ {print $1}' | sed -sn 2p)

  xrandr \
    --output "$_PRIMARY" --primary --mode 1920x1200 --rate 59.95 --pos 0x0 \
    --output "$_SECONDARY" --mode 1920x1080 --rate 120 --pos 1920x60
fi

# Turn off bell, set mouse acceleration/threshold, dim screen after 3 minutes
# and lock 2 minutes later
xset -b m 3 6 s 180 120