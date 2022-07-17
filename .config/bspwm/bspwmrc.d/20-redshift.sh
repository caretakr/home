#!/bin/sh

#
# redshift startup
#

if pgrep -x redshift >/dev/null; then
    killall redshift >/dev/null

    while pgrep -x redshift >/dev/null; do sleep 1; done
fi

redshift & disown
