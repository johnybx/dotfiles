#!/bin/bash
set -e

sudo btrfs su c /var/lib/docker
UUID="7d012e03-ebb3-4975-90d9-5d9ec4614575"

# Check if disk really exists
ls /dev/disk/by-uuid/7d012e03-ebb3-4975-90d9-5d9ec4614575 > /dev/null

printf "\nUUID=%s     	rw,relatime,compress=zstd:3,ssd,space_cache=v2,subvol=/@var/lib/docker	0 0\n" $UUID | sudo tee -a /etc/fstab

yay -S docker docker-buildx docker-compose
sudo usermod -aG docker "$(id -un)"
echo "You need to relogin in order to run docker without sudo"
