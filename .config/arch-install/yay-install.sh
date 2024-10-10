#!/bin/bash
set -e
(
    cd /tmp || exit
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay || exit
    makepkg -si
)
