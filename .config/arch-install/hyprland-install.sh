#!/bin/bash
set -e

# Install these packages before aquamarine dependencies otherwise non git packages will be
# installed and conflict with hyprland-git
yay -S hyprutils-git hyprwayland-scanner-git
yay -S aquamarine-git
yay -S hyprland-git
yay -S xdg-desktop-portal-hyprland-git
sudo pacman -S qt5-wayland qt6-wayland
# Launcher
yay -S ulauncher
# Clipboard Manager
sudo pacman -S copyq
# Notifications
sudo pacman -S swaync
# Lock Screen
yay -S hyprlock-git hypridle-git
# Hyprcursor theme
# For GTK apps update /usr/share/icons/default/index.theme
# or gsettings set org.gnome.desktop.interface cursor-theme 'BreezeX-RosePine-Linux'
yay -S rose-pine-hyprcursor rose-pine-cursor
# Status bar
yay -S waybar-git
# Login Screen

# Misc
yay -S hyprpicker-git
## Screenshots
## grim -g "$(slurp -d)" - | wl-copy
yay -S grim slurp wl-clipboard swappy
