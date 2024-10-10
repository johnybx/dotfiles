#!/bin/bash
set -e

PARTITION_NAME_EFI="/dev/nvme0n1p1"
PARTITION_NAME_BTRFS="/dev/nvme0n1p5"
BTRFS_DEV_NAME="archlinux"
MOUNTPOINT="/mnt"

cryptsetup luksFormat "$PARTITION_NAME_BTRFS"
cryptsetup luksOpen "$PARTITION_NAME_BTRFS" "$BTRFS_DEV_NAME"
mkfs.btrfs /dev/mapper/"$PARTITION_NAME_BTRFS"

mount /dev/mapper/"$PARTITION_NAME_BTRFS" "$MOUNTPOINT"

btrfs subvolume create @
btrfs subvolume create @home
btrfs subvolume create @home/jan
btrfs subvolume create @home/jan/workspace
btrfs subvolume create @home/jan/workspace/work
btrfs subvolume create @root
btrfs subvolume create @var
btrfs subvolume create @var/cache
btrfs subvolume create @var/log
btrfs subvolume create @snapshots
btrfs subvolume create @boot

umount "$MOUNTPOINT"

mount -ocompress=zstd,subvol=@ /dev/mapper/"$BTRFS_DEV_NAME" "$MOUNTPOINT"
for f in "home" "home/jan" "home/jan/workspace" "home/jan/workspace/work" "root" "var" "var/cache" "var/log"  "snapshots"; do
    mkdir "$MOUNTPOINT"/$f
    mount -ocompress=zstd,subvol=@"$f" /dev/mapper/"$BTRFS_DEV_NAME" "$MOUNTPOINT"/"$f"
done

# images are already compressed
mkdir "$MOUNTPOINT"/boot
mount -ocompress=subvol=@boot /dev/mapper/"$BTRFS_DEV_NAME" "$MOUNTPOINT"/"$f"

mkdir /mnt/efi
mount "$PARTITION_NAME_EFI" /mnt/efi

pacstrap /mnt base linux linux-firmware sudo vim intel-ucode btrfs-progs git
genfstab -U /mnt >> /mnt/etc/fstab
sed -i "s/subvolid=[0-9]\+,//" /mnt/etc/fstab
arch-chroot /mnt
