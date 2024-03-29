#!/bin/sh

#
# "Apple Inc. Apple Internal Keyboard / Trackpad" startup
#

_INPUT_NAME="Apple Inc. Apple Internal Keyboard / Trackpad"
_INPUT_ID="$(/usr/bin/xinput list --id-only "keyboard:$_INPUT_NAME" 2>/dev/null)"

if [ ! -z "$_INPUT_ID" ]; then
  # Set keymap to US/International
  /usr/bin/setxkbmap -device "$_INPUT_ID" -layout us -variant alt-intl
fi
