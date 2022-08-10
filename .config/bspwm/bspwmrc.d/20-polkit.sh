#!/bin/sh

#
# polkit startup
#

if /usr/bin/pgrep -x polkit-mate-aut >/dev/null; then
    /usr/bin/killall polkit-mate-authentication-agent-1 >/dev/null

    while /usr/bin/pgrep -x polkit-mate-aut >/dev/null; do /usr/bin/sleep 1; done
fi

/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 & disown
