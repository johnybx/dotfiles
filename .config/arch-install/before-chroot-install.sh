#!/bin/bash
set -e

PARTITION_NAME_EFI="/dev/nvme0n1p1"
PARTITION_NAME_BTRFS="/dev/nvme0n1p5"
BTRFS_DEV_NAME="archlinux"
MOUNTPOINT="/mnt"

cryptsetup luksFormat "$PARTITION_NAME_BTRFS"
cryptsetup luksOpen "$PARTITION_NAME_BTRFS" "$BTRFS_DEV_NAME"
mkfs.btrfs /dev/mapper/"$BTRFS_DEV_NAME"

mount /dev/mapper/"$BTRFS_DEV_NAME" "$MOUNTPOINT"

btrfs subvolume create "$MOUNTPOINT/"@
btrfs subvolume create "$MOUNTPOINT/"@home
btrfs subvolume create "$MOUNTPOINT/"@home/jan
btrfs subvolume create "$MOUNTPOINT/"@home/jan/workspace
btrfs subvolume create "$MOUNTPOINT/"@home/jan/workspace/work
btrfs subvolume create "$MOUNTPOINT/"@home/jan/workspace/git
btrfs subvolume create "$MOUNTPOINT/"@root
btrfs subvolume create "$MOUNTPOINT/"@var
btrfs subvolume create "$MOUNTPOINT/"@var/cache
btrfs subvolume create "$MOUNTPOINT/"@var/log
btrfs subvolume create "$MOUNTPOINT/"@var/lib
btrfs subvolume create "$MOUNTPOINT/"@var/lib/pacman
btrfs subvolume create "$MOUNTPOINT/"@snapshots
btrfs subvolume create "$MOUNTPOINT/"@boot

umount "$MOUNTPOINT"

mount -ocompress=zstd,subvol=@ /dev/mapper/"$BTRFS_DEV_NAME" "$MOUNTPOINT"
for f in "home" "home/jan" "home/jan/workspace" "home/jan/workspace/git" "home/jan/workspace/work" "root" "var" "var/cache" "var/log" "var/lib" "var/lib/pacman" "snapshots"; do
    mkdir -p "$MOUNTPOINT"/$f
    mount -ocompress=zstd,subvol=@"$f" /dev/mapper/"$BTRFS_DEV_NAME" "$MOUNTPOINT"/"$f"
done

# images are already compressed
mkdir "$MOUNTPOINT"/boot
mount -osubvol=@boot /dev/mapper/"$BTRFS_DEV_NAME" "$MOUNTPOINT"/"$f"

mkdir /mnt/efi
mount "$PARTITION_NAME_EFI" /mnt/efi

pacstrap /mnt base linux linux-firmware linux-headers sudo vim intel-ucode btrfs-progs git
genfstab -U /mnt >> /mnt/etc/fstab
sed -i "s/subvolid=[0-9]\+,//" /mnt/etc/fstab
arch-chroot /mnt
