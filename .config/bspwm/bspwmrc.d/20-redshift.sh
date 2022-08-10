#!/bin/sh

#
# redshift startup
#

if /usr/bin/pgrep -x redshift >/dev/null; then
    /usr/bin/killall redshift >/dev/null

    while /usr/bin/pgrep -x redshift >/dev/null; do /usr/bin/sleep 1; done
fi

/usr/bin/redshift & disown
