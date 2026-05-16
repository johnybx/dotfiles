#!/bin/bash

sudo pacman -Sy kdeconnect
# https://github.com/gfhdhytghd/hypr-kdeconnect-fix
yay hypr-kdeconnect-fix

mkdir -p ~/.config/xdg-desktop-portal/
cp ./portals.conf ~/.config/xdg-desktop-portal/

systemctl --user daemon-reload
systemctl --user restart xdg-desktop-portal
systemctl --user stop hypr-kdeconnect-portal.service


# Get device id
# kdeconnect-cli --list-devices
# Mount phone storage
# busctl --user call org.kde.kdeconnect /modules/kdeconnect/devices/$DEVICE_ID/sftp org.kde.kdeconnect.device.sftp mountAndWait
# Get mount storage
# busctl --user call org.kde.kdeconnect /modules/kdeconnect/devices/$DEVICE_ID/sftp org.kde.kdeconnect.device.sftp getDirectories

# NOTE: directory /run/user/1000/$DEVICE_ID is not directly accesible
