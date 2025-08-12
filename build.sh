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

# repos
# rpm-ostree install \
# https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
# https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# installs
rpm-ostree install \
jbigkit \
ImageMagick \
ghostscript \
inotify-tools \
mangohud \
virt-install \
libvirt-daemon-config-network \
libvirt-daemon-kvm \
qemu-kvm \
virt-manager \
virt-viewer \
btrfs-assistant \
baobab \
gnome-software \
gparted \
dkms \
spice-gtk-tools \
java-21-openjdk.x86_64 \
gnome-shell-extension-forge \
gnome-shell-extension-drive-menu \
gnome-shell-extension-just-perfection

# git clones
git clone https://github.com/somepaulo/MoreWaita.git /tmp/MoreWaita
git clone https://github.com/revisitor/ricoh-sp100.git /tmp/ricoh
git clone https://github.com/berarma/new-lg4ff.git /usr/src/new-lg4ff

# printer drivers
cp /tmp/ricoh/pstoricohddst-gdi /usr/lib/cups/filter
chmod 0555 /usr/lib/cups/filter/pstoricohddst-gdi
chown root:root /usr/lib/cups/filter/pstoricohddst-gdi

#### Example for enabling a System Unit File

systemctl enable podman.socket
