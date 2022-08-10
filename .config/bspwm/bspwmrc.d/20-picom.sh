#!/bin/sh

#
# picom startup
#

if /usr/bin/pgrep -x picom >/dev/null; then
    /usr/bin/killall picom >/dev/null

    while /usr/bin/pgrep -x picom >/dev/null; do /usr/bin/sleep 1; done
fi

/usr/bin/picom -f & disown
