#!/bin/sh

#
# dunst startup
#

if pgrep -x dunst >/dev/null; then
    killall dunst >/dev/null

    while pgrep -x dunst >/dev/null; do sleep 1; done
fi

dunst & disown
