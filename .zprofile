#
# ZSH profile
#

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
    # Start X11 on first tty and protect against termination
    exec xinit "$HOME/.config/X11/xinit/xinitrc" \
        -- "$HOME/.config/X11/xinit/xserverrc" :1
fi
