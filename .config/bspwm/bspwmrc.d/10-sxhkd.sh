#!/bin/sh

#
# (S)uper (X) (h)ot(k)ey (d)aemon startup
#

if pgrep -x sxhkd >/dev/null; then
    killall sxhkd >/dev/null

    while pgrep -x sxhkd >/dev/null; do sleep 1; done
fi

sxhkd & disown
