#!/bin/sh

#
# xss-lock startup
#

if pgrep -x xss-lock >/dev/null; then
    killall xss-lock >/dev/null

    while pgrep -x xss-lock >/dev/null; do sleep 1; done
fi

xss-lock slock & disown
