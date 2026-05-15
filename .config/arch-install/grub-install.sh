#!/bin/bash
set -e

# Grub support luks2 argon2id but the default key memory must be currently lowered from default 1GB (--pbkdf-memory)
sudo pacman -Sy grub

echo "Update config files:"
printf "\t/etc/mkinitcpio.conf:\n"
echo "MODULES=(btrfs)
BINARIES=(fsck fsck.btrfs btrfs btrfsck)
FILES=(/etc/cryptsetup-keys.d/archlinux.key)
HOOKS=(base systemd autodetect microcode modconf kms keyboard block sd-encrypt filesystems fsck)
"
printf "\t/etc/default/grub - add 'GRUB_CMDLINE_LINUX=\"rd.luks.name=d128436a-a91f-494d-9afb-4071d3a99474=archlinux root=/dev/mapper/archlinux\"'\n"
printf "\tuncomment GRUB_ENABLE_CRYPTODISK\n"

echo "Press Enter to continue"

read

sudo grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB --recheck
dd bs=512 count=4 if=/dev/random iflag=fullblock | sudo install -m 0600 /dev/stdin /etc/cryptsetup-keys.d/archlinux.key
sudo cryptsetup -v luksAddKey /dev/nvme0n1p5 /etc/cryptsetup-keys.d/archlinux.key

sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo mkinitcpio -P
