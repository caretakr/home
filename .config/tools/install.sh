#!/bin/sh

#
# Install
#

set -e

if [ "$EUID" -eq 0 ]; then
    echo "Please run as user: exiting..."; exit
fi

_log() {
    printf "\n▶ $1\n\n"
}

_main() {
    _log "Setting SSH"...

    mkdir -p /home/caretakr/.ssh

    cat <<EOF > /home/caretakr/.ssh/authorized_keys
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFEG40ygu8lYHrXJrbBE0m+vHHhT2VCxlBaEmXvyC6MF (none)
EOF

    chown caretakr:caretakr /home/caretakr/.ssh
    chmod 0700 /home/caretakr/.ssh
    chown caretakr:caretakr /home/caretakr/.ssh/authorized_keys
    chmod 0600 /home/caretakr/.ssh/authorized_keys

    _log "Setting Paru..."

    git clone https://aur.archlinux.org/paru.git /var/tmp/paru

    sh -c \
        "(cd /var/tmp/paru && makepkg -si --noconfirm && cd / && rm -rf /var/tmp/paru)"

    _log "Setting AUR packages..."

    _AUR_PACKAGES=" \
        nerd-fonts-complete \
        plymouth-git \
        xbanish \
    "

    for p in $_AUR_PACKAGES; do
        while ! paru -S --noconfirm $p; do
            sleep 1
        done
    done

    _log "Setting udev rules..."

    sudo sh -c 'cat <<EOF > /etc/udev/rules.d/20-input.rules
ACTION=="bind", SUBSYSTEM=="hid", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/caretakr/.Xauthority", RUN+="/usr/bin/su caretakr -c /home/caretakr/.config/X11/xinit/xinitrc.d/20-input.sh"
EOF'

    _log "Setting services..."

    systemctl --user enable podman.service
}

_main "$@"