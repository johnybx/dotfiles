#!/bin/bash
set -e

yay -S hyprland
sudo pacman -S qt5-wayland qt6-wayland

# Launcher
yay -S ulauncher

# Clipboard Manager
sudo pacman -S copyq

# Notifications
sudo pacman -S swaync

# Lock Screen
yay -S hyprlock hypridle

# Hyprcursor theme
# For GTK apps update /usr/share/icons/default/index.theme
# or gsettings set org.gnome.desktop.interface cursor-theme 'BreezeX-RosePine-Linux'
yay -S rose-pine-hyprcursor rose-pine-cursor
gsettings set org.gnome.desktop.interface cursor-theme 'BreezeX-RosePine-Linux'
gsettings set org.gnome.desktop.interface cursor-size 24

# GTK-* theme
yay -S arc-gtk-theme arc-icon-theme
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gtk-theme Arc-Dark
gsettings set org.gnome.desktop.interface icon-theme Arc

# Status bar
yay -S waybar

# Login Screen
(
    cd nwg-hello
    sudo bash ./install.sh
)

# Misc
yay -S hyprpicker xdg-desktop-portal-hyprland hyprpaper hyprpwcenter

# Screenshots
## grim -g "$(slurp -d)" - | wl-copy
yay -S grim slurp wl-clipboard swappy


# Polkit
yay -S hyprpolkitagent


# Nvidia
sudo pacman -S nvidia-dkms nvidia-utils egl-wayland libva-nvidia-driver mesa-utils nvidia-settings
