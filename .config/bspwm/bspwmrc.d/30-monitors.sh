#!/bin/sh

#
# Monitors startup
#

_MONITORS="$(/usr/bin/bspc query -M)"
_CONNECTED="$(echo -n "$_MONITORS" | grep -c '^')"

if [ "$_CONNECTED" = 1 ]; then
	/usr/bin/bspc monitor -d 1 2 3 4 5 6 7 8 9 0
elif [ "$_CONNECTED" = 2 ]; then
	_PRIMARY="$(echo "$_MONITORS" | awk NR==2)"
	_SECONDARY="$(echo "$_MONITORS" | awk NR==1)"

	if /usr/bin/xrandr --query | /usr/bin/grep "^$_PRIMARY" | /usr/bin/grep " connected" | grep "[0-9]x[0-9]\+[0-9]\+[0-9]" >/dev/null; then
        /usr/bin/bspc monitor "$_PRIMARY" -d 2 3 4 5 6 7 8 9 0
		/usr/bin/bspc monitor "$_SECONDARY" -d 1
    else
		/usr/bin/bspc monitor "$_SECONDARY" -d 1 2 3 4 5 6 7 8 9 0
	fi
fi