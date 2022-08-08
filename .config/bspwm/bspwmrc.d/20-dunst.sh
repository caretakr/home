#!/bin/sh

#
# dunst startup
#

if /usr/bin/pgrep -x dunst >/dev/null; then
    /usr/bin/killall dunst >/dev/null

    while /usr/bin/pgrep -x dunst >/dev/null; do /usr/bin/sleep 1; done
fi

/usr/bin/dunst & disown
