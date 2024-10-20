#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
rpm-ostree install jbigkit
rpm-ostree install ImageMagick
rpm-ostree install ghostscript
rpm-ostree install inotify-tools
rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
rpm-ostree install android-tools
rpm-ostree install gnome-shell-extension-forge
# rpm-ostree install gnome-shell-extension-
rpm-ostree install gnome-shell-extension-just-perfection
rpm-ostree install mangohud
rpm-ostree install morewaita-icon-theme

# this would install a package from rpmfusion
# rpm-ostree install VirtualBox

#### Example for enabling a System Unit File

systemctl enable podman.socket
