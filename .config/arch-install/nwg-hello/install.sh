#!/bin/bash
set -e

yay -S greetd nwg-hello
sudo cp ./greetd-config.toml /etc/greetd/config.toml
sudo cp ./hyprland.desktop /usr/share/wayland-sessions/hyprland.desktop
sudo cp ./hyprland-custom.conf /etc/nwg-hello/
sudo cp ./nwg-hello.json /etc/nwg-hello/

