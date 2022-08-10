#!/bin/sh

#
# xbanish startup
#

if /usr/bin/pgrep -x xbanish >/dev/null; then
    /usr/bin/killall xbanish >/dev/null

    while /usr/bin/pgrep -x xbanish >/dev/null; do /usr/bin/sleep 1; done
fi

/usr/bin/xbanish & disown
