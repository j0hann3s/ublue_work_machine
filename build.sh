#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# bootc problem with selinux labels (swtpm for example)
touch /.autorelabel
/sbin/restorecon -v /usr/bin/swtpm

# prepare hashicorp repo.
curl https://rpm.releases.hashicorp.com/fedora/hashicorp.repo > /etc/yum.repos.d/hashicorp.repo

# this installs a package from fedora repos
rpm-ostree install --apply-live ansible htop libguestfs p7zip p7zip-plugins python3-psutil qemu-kvm setroubleshoot terraform virt-manager virt-viewer

/sbin/restorecon -v /usr/bin/swtpm
