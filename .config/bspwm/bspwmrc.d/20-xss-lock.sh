#!/bin/sh

#
# xss-lock startup
#

if /usr/bin/pgrep -x xss-lock >/dev/null; then
    /usr/bin/killall xss-lock >/dev/null

    while /usr/bin/pgrep -x xss-lock >/dev/null; do /usr/bin/sleep 1; done
fi

/usr/bin/xss-lock slock & disown
