#!/bin/sh

#
# "DLL0945:00 06CB:CDE6 Touchpad" startup
#

_INPUT_NAME="DLL0945:00 06CB:CDE6 Touchpad"
_INPUT_ID="$(xinput list --id-only "pointer:$_INPUT_NAME" 2>/dev/null)"

if [ ! -z "$_INPUT_ID" ]; then
    # Set tapping, dragging and natural scrolling
    xinput --set-prop "$_INPUT_ID" "libinput Tapping Enabled" 1
    xinput --set-prop "$_INPUT_ID" "libinput Tapping Drag Enabled" 0
    xinput --set-prop "$_INPUT_ID" "libinput Natural Scrolling Enabled" 1
fi
