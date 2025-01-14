#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

# repos
rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | tee -a /etc/yum.repos.d/vscodium.repo
rpm-ostree install \
https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

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
android-tools \
codium \
mangohud \
goverlay \
java-latest-openjdk

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

## MoreWaita
# mkdir -p /usr/share/icons/MoreWaita/
# shopt -s extglob
# cp -avu "/tmp/MoreWaita"/!(*.build|*.sh|*.py|*.md|.git|.github|.gitignore|_dev) /usr/share/icons/MoreWaita/
# shopt -u extglob
# find /usr/share/icons/MoreWaita/ -name '*.build' -type f -delete

#### Example for enabling a System Unit File

systemctl enable podman.socket
