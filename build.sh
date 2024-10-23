#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

# removes
rpm-ostree override remove \
    gnome-classic-session \
	gnome-classic-session-xsession \
    gnome-shell-extension-apps-menu \
    gnome-shell-extension-launch-new-instance \
    gnome-shell-extension-places-menu \
    gnome-shell-extension-window-list \
    gnome-shell-extension-blur-my-shell \
    gnome-shell-extension-background-logo

# machine-id fix
touch /etc/machine-id
dbus-uuidgen >> /etc/machine-id
service dbus restart

# repos
rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | tee -a /etc/yum.repos.d/vscodium.repo
rpm-ostree install \
https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

# programs
rpm-ostree install \
jbigkit \
ImageMagick \
ghostscript \
inotify-tools \
android-tools \
codium \
mangohud

# gnome-shell-extension-installer
cd /tmp
wget -O gnome-shell-extension-installer "https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"
chmod +x gnome-shell-extension-installer
mv gnome-shell-extension-installer /usr/bin/

# extensions
rpm-ostree install \
gnome-shell-extension-forge \
gnome-shell-extension-drive-menu \
gnome-shell-extension-just-perfection
# Bedtime Mode
gnome-shell-extension-installer 4012
# Bing Wallpaper
gnome-shell-extension-installer 1262
# Bluetooth battery indicator
gnome-shell-extension-installer 3991
# Clipboard History
gnome-shell-extension-installer 4839
# DualShock/DualSense battery percentage
gnome-shell-extension-installer 1283
# Extension List
gnome-shell-extension-installer 3088
# OSD Volume Number
gnome-shell-extension-installer 5461
# Panel corners
gnome-shell-extension-installer 4805
# Quick Setting Tweaker
gnome-shell-extension-installer 5446
# Quick Settings Audio Devices Hider
gnome-shell-extension-installer 5964
# Rounded Corners
gnome-shell-extension-installer 1514
# Rounded Window Corners Reborn
gnome-shell-extension-installer 7048
# Windows Is Ready - Notification Remover
gnome-shell-extension-installer 1007

# git clones
git clone https://github.com/somepaulo/MoreWaita.git /tmp/MoreWaita
git clone https://github.com/revisitor/ricoh-sp100.git /tmp/ricoh

# printer drivers
cp /tmp/ricoh/pstoricohddst-gdi /usr/lib/cups/filter

#### Example for enabling a System Unit File

systemctl enable podman.socket
