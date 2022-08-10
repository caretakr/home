#!/bin/sh

#
# "Designer Mouse" startup
#

_INPUT_NAME="Designer Mouse"
_INPUT_ID="$(/usr/bin/xinput list --id-only "pointer:$_INPUT_NAME" 2>/dev/null)"

if [ ! -z "$_INPUT_ID" ]; then
    # Set acceleration speed
    /usr/bin/xinput --set-prop "$_INPUT_ID" "libinput Accel Speed" -0.5
fi
