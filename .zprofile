#
# ZSH profile
#

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
    # Start X11 on first tty and protect against termination
    exec startx "$HOME/.xinitrc" -- "$HOME/.xserverrc" :0
fi
