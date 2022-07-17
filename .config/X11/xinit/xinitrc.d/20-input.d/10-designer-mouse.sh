#!/bin/sh

#
# "Designer Mouse" startup
#

_INPUT_NAME="Designer Mouse"
_INPUT_ID="$(xinput list --id-only "pointer:$_INPUT_NAME" 2>/dev/null)"

if [ ! -z "$_INPUT_ID" ]; then
    # Set acceleration speed
    xinput --set-prop "$_INPUT_ID" "libinput Accel Speed" -0.5
fi
