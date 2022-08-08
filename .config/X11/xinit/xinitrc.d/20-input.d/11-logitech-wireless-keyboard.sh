#!/bin/sh

#
# "Logitech Wireless Keyboard" startup
#

_INPUT_NAME="Logitech Wireless Keyboard PID:4023"
_INPUT_ID="$(/usr/bin/xinput list --id-only "keyboard:$_INPUT_NAME" 2>/dev/null)"

if [ ! -z "$_INPUT_ID" ]; then
    # Set keymap to US/International
    /usr/bin/setxkbmap -device "$_INPUT_ID" -layout br -variant abnt2
fi
