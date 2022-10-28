#!/bin/sh

#
# Java startup
#

# Fix "white windows" when opening Java applications
export _JAVA_AWT_WM_NONREPARENTING=1

# Fix font anti-aliasing
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
