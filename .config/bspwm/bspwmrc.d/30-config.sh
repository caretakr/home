#!/bin/sh

#
# Config startup
#

_XRESOURCES_DPI="$(xrdb -query | grep "Xft.dpi" | cut -f 2)"
_XRESOURCES_DPI="${_XRESOURCES_DPI:-96}"

if [ "$_XRESOURCES_DPI" = "96" ]; then
    _TOP_PADDING="64"
else
    _TOP_PADDING="72"
fi

# Set global settings
/usr/bin/bspc config split_ratio 0.52
/usr/bin/bspc config automatic_scheme longest_side
/usr/bin/bspc config focus_follows_pointer true
/usr/bin/bspc config pointer_follows_focus false
/usr/bin/bspc config pointer_follows_monitor false
/usr/bin/bspc config borderless_monocle true
/usr/bin/bspc config gapless_monocle true

# Set node settings
/usr/bin/bspc config border_width 2
/usr/bin/bspc config normal_border_color "$(xrdb -get "*.background")"
/usr/bin/bspc config active_border_color "$(xrdb -get "*.background")"
/usr/bin/bspc config focused_border_color "$(xrdb -get "*.color4")"

# Set desktop settings
/usr/bin/bspc config top_padding $_TOP_PADDING
/usr/bin/bspc config window_gap 20
