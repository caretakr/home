#!/bin/sh

#
# Rules startup
#

bspc rule -a mpv state=floating sticky=on follow=off focus=on \
    rectangle=640x360+2760+1040
bspc rule -a "*:Toolkit:Picture-in-Picture" state=floating sticky=on \
    follow=off focus=on rectangle=640x360+2760+1040
