#!/bin/sh

#
# Systemd startup
#

# Import environment variables
systemctl --user import-environment \
    _JAVA_AWT_WM_NONREPARENTING \
    _JAVA_OPTIONS \
    DBUS_SESSION_BUS_ADDRESS \
    MOZ_USE_XINPUT2 \
    XDG_DATA_HOME \
    QT_STYLE_OVERRIDE

# Start target for services
systemctl --no-block --user start xsession.target
