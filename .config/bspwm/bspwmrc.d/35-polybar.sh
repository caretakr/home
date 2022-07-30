#!/bin/sh

#
# Polybar startup
#

# Create log directory if not exists
if [[ ! -d "$XDG_DATA_HOME/polybar" ]]; then
    mkdir -p "$XDG_DATA_HOME/polybar"
fi

if pgrep -x polybar >/dev/null; then
    killall polybar >/dev/null

    while pgrep -x polybar >/dev/null; do sleep 1; done
fi

_TEMPERATURE_THERMAL_ZONE="$(for i in /sys/class/thermal/thermal_zone*; do if [ "$(<$i/type)" = "x86_pkg_temp" ]; then echo "${i:(-1)}"; fi; done)"
_TEMPERATURE_HWMON_PATH="$(for i in /sys/class/hwmon/hwmon*/temp*_input; do if [[ "$(<$(dirname $i)/name)" = "coretemp" && "$(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*}))" = "Package id 0" ]]; then echo "$(readlink -f $i)"; fi; done)"

_XRESOURCES_DPI="$(xrdb -query | grep "Xft.dpi" | cut -f 2)"
_XRESOURCES_DPI="${_XRESOURCES_DPI:-96}"

for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    _VIEWPORT_WIDTH="$(xrandr --query | grep "^$m" | sed 's/ primary//g' | cut -d" " -f3 | cut -d"x" -f1)"

    _PADDING="24"
    
    _LAUNCHER_WIDTH="$((((56*$_XRESOURCES_DPI)+60)/120))"
    _WORKSPACES_WIDTH="$(((((50*$(echo "$(bspc query -D -m $m)" | grep -c '^'))*$_XRESOURCES_DPI)+60)/120))"
    _MODULES0_WIDTH="$((((348*$_XRESOURCES_DPI)+60)/120))"
    _MODULES1_WIDTH="$((((436*$_XRESOURCES_DPI)+60)/120))"
    _TIMESTAMP_WIDTH="$((((223*$_XRESOURCES_DPI)+60)/120))"
    _POWER_WIDTH="$((((56*$_XRESOURCES_DPI)+60)/120))"

    _LAUNCHER_OFFSET_X="$_PADDING"
    _WORKSPACES_OFFSET_X="$(($_PADDING + $_LAUNCHER_WIDTH + ($_PADDING/2)))"
    _MODULES0_OFFSET_X="$(($_VIEWPORT_WIDTH - $_PADDING - $_POWER_WIDTH - ($_PADDING/2) - $_TIMESTAMP_WIDTH - ($_PADDING/2) - $_MODULES0_WIDTH))"
    _MODULES1_OFFSET_X="$(($_VIEWPORT_WIDTH - $_PADDING - $_POWER_WIDTH - ($_PADDING/2) - $_TIMESTAMP_WIDTH - ($_PADDING/2) - $_MODULES0_WIDTH - ($_PADDING/2) - $_MODULES1_WIDTH))"
    _TIMESTAMP_OFFSET_X="$(($_VIEWPORT_WIDTH - $_PADDING - $_POWER_WIDTH - ($_PADDING/2) - $_TIMESTAMP_WIDTH))"
    _POWER_OFFSET_X="$(($_VIEWPORT_WIDTH - $_PADDING - $_POWER_WIDTH))"

    _LINE_HEIGHT="$((((2*$_XRESOURCES_DPI)+60)/120))px"

    if [ "$_XRESOURCES_DPI" = "96" ]; then
        _HEIGHT="40px"

        _FONT0_ALIGNMENT="2"
        _FONT1_ALIGNMENT="2"
        _FONT2_ALIGNMENT="4"
        _FONT3_ALIGNMENT="5"
    else
        _HEIGHT="48px"

        _FONT0_ALIGNMENT="2"
        _FONT1_ALIGNMENT="4"
        _FONT2_ALIGNMENT="4"
        _FONT3_ALIGNMENT="6"
    fi

    _FONT0="FiraMono Nerd Font:size=9.6;$_FONT0_ALIGNMENT"
    _FONT1="FiraMono Nerd Font Mono:size=12.8;$_FONT1_ALIGNMENT"
    _FONT2="FiraMono Nerd Font Mono:size=16;$_FONT2_ALIGNMENT"
    _FONT3="FiraMono Nerd Font Mono:size=19.2;$_FONT3_ALIGNMENT"

    MONITOR="$m" \
        WIDTH="${_LAUNCHER_WIDTH}px" \
        HEIGHT="$_HEIGHT" \
        OFFSET_X="${_LAUNCHER_OFFSET_X}px" \
        LINE_HEIGHT="$_LINE_HEIGHT" \
        FONT0="$_FONT0" \
        FONT1="$_FONT1" \
        FONT2="$_FONT2" \
        FONT3="$_FONT3" \
        polybar --reload launcher >$XDG_DATA_HOME/polybar/launcher.log 2>&1 & disown

    MONITOR="$m" \
        WIDTH="${_WORKSPACES_WIDTH}px" \
        HEIGHT="$_HEIGHT" \
        OFFSET_X="${_WORKSPACES_OFFSET_X}px" \
        LINE_HEIGHT="$_LINE_HEIGHT" \
        FONT0="$_FONT0" \
        FONT1="$_FONT1" \
        FONT2="$_FONT2" \
        FONT3="$_FONT3" \
        polybar --reload workspaces >$XDG_DATA_HOME/polybar/workspaces.log 2>&1 & disown

    MONITOR="$m" \
        WIDTH="${_MODULES0_WIDTH}px" \
        HEIGHT="$_HEIGHT" \
        OFFSET_X="${_MODULES0_OFFSET_X}px" \
        LINE_HEIGHT="$_LINE_HEIGHT" \
        FONT0="$_FONT0" \
        FONT1="$_FONT1" \
        FONT2="$_FONT2" \
        FONT3="$_FONT3" \
        polybar --reload modules0 >$XDG_DATA_HOME/polybar/modules0.log 2>&1 & disown

    if [ "$_VIEWPORT_WIDTH" = "1920" ]; then
        MONITOR="$m" \
            WIDTH="${_MODULES1_WIDTH}px" \
            HEIGHT="$_HEIGHT" \
            OFFSET_X="${_MODULES1_OFFSET_X}px" \
            LINE_HEIGHT="$_LINE_HEIGHT" \
            FONT0="$_FONT0" \
            FONT1="$_FONT1" \
            FONT2="$_FONT2" \
            FONT3="$_FONT3" \
            TEMPERATURE_THERMAL_ZONE="$_TEMPERATURE_THERMAL_ZONE" \
            TEMPERATURE_HWMON_PATH="$_TEMPERATURE_HWMON_PATH" \
            polybar --reload modules1 >$XDG_DATA_HOME/polybar/modules1.log 2>&1 & disown
    fi

    MONITOR="$m" \
        WIDTH="${_TIMESTAMP_WIDTH}px" \
        HEIGHT="$_HEIGHT" \
        OFFSET_X="${_TIMESTAMP_OFFSET_X}px" \
        LINE_HEIGHT="$_LINE_HEIGHT" \
        FONT0="$_FONT0" \
        FONT1="$_FONT1" \
        FONT2="$_FONT2" \
        FONT3="$_FONT3" \
        polybar --reload timestamp >$XDG_DATA_HOME/polybar/timestamp.log 2>&1 & disown

    MONITOR="$m" \
        WIDTH="${_POWER_WIDTH}px" \
        HEIGHT="$_HEIGHT" \
        OFFSET_X="${_POWER_OFFSET_X}px" \
        LINE_HEIGHT="$_LINE_HEIGHT" \
        FONT0="$_FONT0" \
        FONT1="$_FONT1" \
        FONT2="$_FONT2" \
        FONT3="$_FONT3" \
        polybar --reload power >$XDG_DATA_HOME/polybar/power.log 2>&1 & disown
done
