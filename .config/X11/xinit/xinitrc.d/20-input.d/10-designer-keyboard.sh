#!/bin/sh

#
# "Microsoft Keyboard" startup
#

_INPUT_NAME="Designer Keyboard"
_INPUT_ID="$(xinput list --id-only "keyboard:$_INPUT_NAME" 2>/dev/null)"

if [ ! -z "$_INPUT_ID" ]; then
    # Set keymap to US/International
    setxkbmap -device "$_INPUT_ID" -layout us -variant alt-intl
fi
