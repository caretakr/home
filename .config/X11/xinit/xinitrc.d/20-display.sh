#!/bin/sh

#
# Display startup
#

_CONNECTED=$(/usr/bin/xrandr -q | /usr/bin/awk '/ connected/ {count++} END {print count}')
_PRIMARY=$(/usr/bin/xrandr -q | /usr/bin/awk '/ connected/ {print $1}' | /usr/bin/sed -sn 1p)

if [ "$_CONNECTED" = 1 ]; then
  /usr/bin/xrandr \
      --output "$_PRIMARY" --primary --mode 1920x1200 --rate 59.95 --pos 0x0
elif [ "$_CONNECTED" = 2 ]; then
  _SECONDARY=$(/usr/bin/xrandr -q | awk '/ connected/ {print $1}' | sed -sn 2p)

  /usr/bin/xrandr \
      --output "$_PRIMARY" --primary --mode 1920x1200 --rate 59.95 --pos 0x0 \
      --output "$_SECONDARY" --mode 1920x1080 --rate 120 --pos 1920x0
fi

# Turn off bell, set mouse acceleration/threshold, dim screen after 3 minutes
# and lock 2 minutes later
/usr/bin/xset -b m 3 6 s 180 120
