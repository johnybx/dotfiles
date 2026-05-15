#!/bin/bash
set -e

sudo btrfs su c /var/lib/libvirt

printf "\nUUID=%s     	rw,relatime,compress=zstd:3,ssd,space_cache=v2,subvol=/@var/lib/libvirt	0 0\n" "$UUID" | sudo tee -a /etc/fstab

pacman -Sy libvirt dnsmasq dmidecode virt-manager iptables-nft qemu-full
