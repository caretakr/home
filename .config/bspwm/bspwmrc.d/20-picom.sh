#!/bin/sh

#
# picom startup
#

if pgrep -x picom >/dev/null; then
    killall picom >/dev/null

    while pgrep -x picom >/dev/null; do sleep 1; done
fi

picom -f & disown
