#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# prepare hashicorp repo.
curl https://rpm.releases.hashicorp.com/fedora/hashicorp.repo > /etc/yum.repos.d/hashicorp.repo
# this installs a package from fedora repos
rpm-ostree install ansible htop libguestfs python3-psutil qemu-kvm terraform virt-manager virt-viewer
# Keep row below until Fedora 42 with fixed LUKS2 decryption screen.
rpm-ostree initramfs-etc --track=/etc/vconsole.conf

# this would install a package from rpmfusion
# rpm-ostree install vlc

#### Example for enabling a System Unit File

systemctl enable podman.socket
