#!/bin/sh

#
# Monitors startup
#

_MONITORS="$(bspc query -M)"
_CONNECTED="$(echo -n "$_MONITORS" | grep -c '^')"

if [ "$_CONNECTED" = 1 ]; then
	bspc monitor -d 1 2 3 4 5 6 7 8 9 0
elif [ "$_CONNECTED" = 2 ]; then
	_PRIMARY="$(echo "$_MONITORS" | awk NR==2)"
	_SECONDARY="$(echo "$_MONITORS" | awk NR==1)"

	bspc monitor "$_PRIMARY" -d 2 3 4 5 6 7 8 9 0
	bspc monitor "$_SECONDARY" -d 1
fi
