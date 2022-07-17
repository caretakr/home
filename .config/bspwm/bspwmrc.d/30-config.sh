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
bspc config split_ratio 0.52
bspc config automatic_scheme longest_side
bspc config focus_follows_pointer true
bspc config pointer_follows_focus false
bspc config pointer_follows_monitor false
bspc config borderless_monocle true
bspc config gapless_monocle true

# Set node settings
bspc config border_width 0

# Set desktop settings
bspc config top_padding $_TOP_PADDING
bspc config window_gap 24