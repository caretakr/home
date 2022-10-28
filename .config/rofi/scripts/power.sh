#!/bin/sh

SHUTDOWN="Shutdown"
REBOOT="Reboot"
LOCK="Lock"
SUSPEND="Suspend"
LOGOUT="Logout"

UPTIME="$(/usr/bin/uptime -p | sed -e 's/up //g')"

CHOSEN=$(printf "$SHUTDOWN\n$REBOOT\n$LOCK\n$SUSPEND\n$LOGOUT" | /usr/bin/rofi -i -p "Uptime: $UPTIME" -dmenu)

case "$CHOSEN" in
  $SHUTDOWN) /usr/bin/systemctl poweroff ;;
  $REBOOT) /usr/bin/systemctl reboot ;;
  $LOCK) /usr/bin/xset dpms force suspend ;;
  $SUSPEND) /usr/bin/systemctl suspend ;;
  $LOGOUT) /usr/bin/bspc quit ;;
  *) exit 1 ;;
esac
