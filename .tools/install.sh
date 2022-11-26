#!/bin/sh

#
# Install
#

set -eu

if [ "$EUID" -eq 0 ]; then
  echo "Please run as user: exiting..."; exit
fi

INPUT=0
STEP=0

_log() {
  printf "%s\n" "$@"
}

_title() {
  printf '%s\n' "$1"

  for ((i=1;i<=${#1};i++)); do
    printf "%s" "-"
  done

  printf "\n\n"
}

_message() {
  printf '%s\n\n' "$@"
}

_input() {
  INPUT=$(($INPUT+1))

  printf "  %s) %s" "$INPUT" "$1"
}

_step() {
  STEP=$(($STEP+1))

  printf "\n" \
    && printf "%02d) %s\n" "$STEP" "$1"
}

_line() {
  for ((i=1;i<=$(tput cols);i++)); do
    printf "%s" "-"
  done

  printf "\n"
}

_main() {
  _title 'Arch user install'

  _step 'Installing Paru...' \
    && _line

  (
    _WORKING_DIRECTORY="$(mktemp -d)"

    sudo sed -i 's/^#Color$/Color/g' /etc/pacman.conf \
      && sudo pacman -S --needed --noconfirm --ask=4 base-devel \
      && git clone https://aur.archlinux.org/paru.git "$_WORKING_DIRECTORY" \
      && cd "$_WORKING_DIRECTORY" \
      && makepkg -si --noconfirm
  )

  _step 'Installing packages...' \
    && _line

  (
    _PACKAGES=" \
      adwaita-qt5 \
      adwaita-qt6 \
      android-studio \
      bridge-utils \
      bspwm \
      btop \
      dmidecode \
      dnsmasq \
      dunst \
      edk2-ovmf \
      feh \
      firefox \
      firefox-developer-edition \
      firewalld \
      flatpak \
      fuse-overlayfs \
      gnome-keyring \
      gnupg \
      google-chrome \
      gtk3 \
      gtk4 \
      iptables-nft \
      kitty \
      libfido2 \
      libnotify \
      libsecret \
      libvirt \
      mate-polkit \
      mpv \
      neovim \
      nerd-fonts-complete \
      netavark \
      noto-fonts \
      noto-fonts-cjk \
      noto-fonts-emoji \
      nvm \
      openbsd-netcat \
      openssh \
      openvpn \
      picom \
      pinentry \
      playerctl \
      plymouth \
      podman \
      podman-dnsname \
      podman-docker \
      polkit \
      polybar \
      qemu-base \
      qt5-base \
      qt6-base \
      redshift \
      rofi \
      rsync \
      rustup \
      seahorse \
      slirp4netns \
      slock \
      swtpm \
      sxhkd \
      telegram-desktop \
      trash-cli \
      unarchiver \
      virt-manager \
      visual-studio-code-bin \
      wireguard-tools \
      xbanish \
      xdg-desktop-portal-gtk \
      xorg-server \
      xorg-xinit \
      xorg-xinput \
      xorg-xrandr \
      xorg-xset \
      xss-lock \
    "

    paru -S --noconfirm --ask=4 $_PACKAGES
  )

  _step 'Setting Node.js...' \
    && _line

  (
    nvm install --lts \
      && nvm use --lts \
      && node -v
  )

  _step 'Setting Rust...' \
    && _line

  (
    rustup default stable \
      && rustc -V
  )

  _step 'Setting virtualization...' \
    && _line

  (
    sudo systemctl enable libvirtd.service
  )

  _step 'Setting containers...' \
    && _line

  (
    sudo touch /etc/subuid /etc/subgid \
      && sudo usermod --add-subuids 100000-165535 --add-subgids 100000-165535 \
          caretakr

    sudo touch /etc/containers/nodocker

    systemctl --user enable podman.service
  )

  _step 'Setting desktop...' \
    && _line

  (
    systemctl --user enable dunst.service \
      && systemctl --user enable dunst.path

    systemctl --user enable fehbg.service \
      && systemctl --user enable fehbg.path

    systemctl --user enable picom.service \
      && systemctl --user enable picom.path

    systemctl --user enable polkit.service

    systemctl --user enable polybar.service \
      && systemctl --user enable polybar.path

    systemctl --user enable redshift.service \
      && systemctl --user enable redshift.path

    systemctl --user enable sxhkd.service \
      && systemctl --user enable sxhkd.path

    systemctl --user enable xbanish.service
    systemctl --user enable xss-lock@slock.service
  )

  _step 'Setting udev...' \
    && _line

  (
    sudo sh -c 'cat <<EOF >/etc/udev/rules.d/20-input.rules
ACTION=="bind", SUBSYSTEM=="hid", ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/caretakr/.Xauthority", RUN+="/usr/bin/su caretakr -c /home/caretakr/.config/X11/xinit/xinitrc.d/20-input.sh"
EOF'
  )

  _step 'Setting SSH...' \
    && _line

  (
    sudo sed -i \
        's/^#PasswordAuthentication yes$/PasswordAuthentication no/g' \
        /etc/ssh/sshd_config
  )

  _step 'Setting firewall...' \
    && _line

  (
    sudo systemctl enable firewalld.service
  )

  _step 'Setting Plymouth...' \
    && _line

  (
    sudo sed -i \
        '/^HOOKS/s/(.*)/(base systemd sd-plymouth autodetect keyboard sd-vconsole modconf block sd-encrypt filesystems fsck)/g' \
        /etc/mkinitcpio.conf

    sudo mkinitcpio -P
  )
}

_main "$@"
