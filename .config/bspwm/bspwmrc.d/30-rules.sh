#!/bin/sh

#
# Rules startup
#

/usr/bin/bspc rule -a mpv state=floating sticky=on follow=off focus=on \
    rectangle=640x360+2760+1040
/usr/bin/bspc rule -a "*:Toolkit:Picture-in-Picture" state=floating sticky=on \
    follow=off focus=on rectangle=640x360+2760+1040
