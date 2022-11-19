#
# ZSH profile
#

# Create log directory if not exists
if [[ ! -d "$XDG_DATA_HOME/xorg" ]]; then
  /usr/bin/mkdir -p "$XDG_DATA_HOME/xorg"
fi

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
  # Start X11 on first tty and protect against termination
  exec /usr/bin/startx "$HOME/.xinitrc" -- "$HOME/.xserverrc" :0 \
      >"$XDG_DATA_HOME/xorg/startx.log" 2>&1
fi
