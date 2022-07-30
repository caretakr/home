#!/bin/sh

#
# Input startup
#

_INPUT_DIRECTORY="$HOME/.config/X11/xinit/xinitrc.d/20-input.d"

if [ -d "$_INPUT_DIRECTORY" ] ; then
    for f in "$_INPUT_DIRECTORY"/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done

    unset f
fi
