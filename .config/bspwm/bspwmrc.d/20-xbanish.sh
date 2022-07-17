#!/bin/sh

#
# xbanish startup
#

if pgrep -x xbanish >/dev/null; then
    killall xbanish >/dev/null

    while pgrep -x xbanish >/dev/null; do sleep 1; done
fi

xbanish & disown
