#!/bin/bash
set -e

sudo pacman -S sudo git sed wget curl httpie openssh openvpn brightnessctl firefox thunderbird man fastfetch zsh vim jq playerctl vlc ranger usbutils tmux fzf bind powertop tlp mariadb-clients glab lshw ncdu tldr whois inxi iftop socat tcpdump bluez bluez-utils blueman ddcutil smartmontools kitty rsync networkmanager network-manager-applet wireguard-tools openvpn viewnior libreoffice-fresh
yay -S slack-desktop-wayland spotify dotool

sudo systemctl enable NetworkManager

