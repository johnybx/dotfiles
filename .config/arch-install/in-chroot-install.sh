#!/bin/bash
set -e

pacman -S --needed git base-devel vim curl wget sed bash-completion efibootmgr networkmanager

timedatectl set-timezone Europe/Bratislava
timedatectl set-ntp true
hwclock --systohc --localtime
sed -i "s/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/" /etc/locale.gen
locale-gen
echo "archlinux" | tee /etc/hostname

echo "127.0.0.1 localhost
::1 localhost
127.0.1.1 archlinux archlinux.localdomain" | tee -a /etc/host.conf

useradd -G wheel jan
passwd jan
sed -i "s/#\+\s*%wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/" /etc/sudoers
