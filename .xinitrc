#!/bin/sh

#
# X startup
#

_SYSTEM_XRESOURCES="/etc/X11/xinit/.Xresources"
_SYSTEM_XMODMAP="/etc/X11/xinit/.Xmodmap"
_SYSTEM_XINITRC_DIRECTORY="/etc/X11/xinit/xinitrc.d"

_USER_XRESOURCES_DIRECTORY="$XDG_CONFIG_HOME/X11/xinit/xresources.d"
_USER_XRESOURCES_LOCAL_DIRECTORY="$XDG_CONFIG_HOME/X11/xinit/xresources.local.d"

_USER_XMODMAP="$XDG_CONFIG_HOME/X11/xinit/.Xmodmap"
_USER_XINITRC_DIRECTORY="$XDG_CONFIG_HOME/X11/xinit/xinitrc.d"

if [ -f "$_SYSTEM_XRESOURCES" ]; then
    /usr/bin/xrdb -merge "$_SYSTEM_XRESOURCES"
fi

if [ -f "$_SYSTEM_XMODMAP" ]; then
    /usr/bin/xmodmap "$_SYSTEM_XMODMAP"
fi

if [ -d "$_USER_XRESOURCES_DIRECTORY" ]; then
    for f in "$_USER_XRESOURCES_DIRECTORY"/*; do
        /usr/bin/xrdb -merge "$f"
    done

    unset f
fi

if [ -d "$_USER_XRESOURCES_LOCAL_DIRECTORY" ]; then
    for f in "$_USER_XRESOURCES_LOCAL_DIRECTORY"/*; do
        /usr/bin/xrdb -merge "$f"
    done

    unset f
fi

if [ -f "$_USER_XMODMAP" ]; then
    /usr/bin/xmodmap "$_USER_XMODMAP"
fi

if [ -d "$_SYSTEM_XINITRC_DIRECTORY" ]; then
    for f in "$_SYSTEM_XINITRC_DIRECTORY"/?*.sh; do
        [ -x "$f" ] && . "$f"
    done

    unset f
fi

if [ -d "$_USER_XINITRC_DIRECTORY" ]; then
    for f in "$_USER_XINITRC_DIRECTORY"/?*.sh; do
        [ -x "$f" ] && . "$f"
    done

    unset f
fi

exec /usr/bin/bspwm
