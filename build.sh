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
    gnome-shell-extension-background-logo

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

# extensions
rpm-ostree install \
gnome-shell-extension-forge \
gnome-shell-extension-just-perfection

# MoreWaita icon theme
git clone https://github.com/somepaulo/MoreWaita.git /tmp/MoreWaita

#### Example for enabling a System Unit File

systemctl enable podman.socket
