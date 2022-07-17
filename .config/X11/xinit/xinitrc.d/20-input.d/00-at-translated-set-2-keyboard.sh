#!/bin/sh

#
# "AT Translated Set 2 keyboard" startup
#

_INPUT_NAME="AT Translated Set 2 keyboard"
_INPUT_ID="$(xinput list --id-only "keyboard:$_INPUT_NAME" 2>/dev/null)"

if [ ! -z "$_INPUT_ID" ]; then
    # Set keymap to BR/ABNT2
    setxkbmap -device "$_INPUT_ID" -layout br -variant abnt2
fi
