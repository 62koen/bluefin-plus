#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

# removes
rpm-ostree override remove \
    gnome-classic-session \
    gnome-shell-extension-apps-menu \
    gnome-shell-extension-launch-new-instance \
    gnome-shell-extension-places-menu \
    gnome-shell-extension-window-list \
    gnome-shell-extension-blur-my-shell

# programs
rpm-ostree install \
jbigkit \
ImageMagick \
ghostscript \
inotify-tools \
mangohud \
goverlay

# extensions
rpm-ostree install \
gnome-shell-extension-forge \
gnome-shell-extension-drive-menu \
gnome-shell-extension-just-perfection

# git clones
git clone https://github.com/somepaulo/MoreWaita.git /tmp/MoreWaita
git clone https://github.com/revisitor/ricoh-sp100.git /tmp/ricoh

# printer drivers
cp /tmp/ricoh/pstoricohddst-gdi /usr/lib/cups/filter
chmod 0555 /usr/lib/cups/filter/pstoricohddst-gdi
chown root:root /usr/lib/cups/filter/pstoricohddst-gdi

#### Example for enabling a System Unit File

systemctl enable podman.socket
