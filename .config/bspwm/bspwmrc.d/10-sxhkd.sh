#!/bin/sh

#
# (S)uper (X) (h)ot(k)ey (d)aemon startup
#

if /usr/bin/pgrep -x sxhkd >/dev/null; then
    /usr/bin/killall sxhkd >/dev/null

    while /usr/bin/pgrep -x sxhkd >/dev/null; do /usr/bin/sleep 1; done
fi

/usr/bin/sxhkd & disown
