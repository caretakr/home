#!/bin/sh

#
# polkit startup
#

if pgrep -x polkit-mate-aut >/dev/null; then
    killall polkit-mate-authentication-agent-1 >/dev/null

    while pgrep -x polkit-mate-aut >/dev/null; do sleep 1; done
fi

/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 & disown
