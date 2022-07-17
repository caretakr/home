#!/bin/sh

#
# "Logitech Wireless Mouse" startup
#

_INPUT_NAME="Logitech Wireless Mouse PID:4022"
_INPUT_ID="$(xinput list --id-only "pointer:$_INPUT_NAME" 2>/dev/null)"

if [ ! -z "$_INPUT_ID" ]; then
    # Set acceleration speed
    xinput --set-prop "$_INPUT_ID" "libinput Accel Speed" -0.5
fi
