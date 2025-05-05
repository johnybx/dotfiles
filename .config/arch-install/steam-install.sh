#!/bin/bash

# Enable multilib

pacman -Sy lib32-nvidia-utils xorg-xhost
pacman -Sy steam


# Setup ENV to run  
# setfacl --recursive -m u:steam:rwx $XDG_RUNTIME_DIR
# xhost si:localuser:steam
# sudo --preserve-env=XDG_SESSION_TYPE --preserve-env=WAYLAND_DISPLAY --preserve-env=DISPLAY --preserve-env=XDG_RUNTIME_DIR -u steam steam

# With sound
# need to enable tcp in ~/.config/pipewire/pipewire-pulse.conf.d/override.conf
# PULSE_SERVER=tcp:127.0.0.1:4713 sudo --preserve-env=XDG_SESSION_TYPE,WAYLAND_DISPLAY,DISPLAY,XDG_RUNTIME_DIR,PULSE_SERVER  -u steam bash

# Games use various port and we have iptables in place !
# Pasting to windows:
# sleep 5; xdotool type -- "$(wl-paste)"

# TODO: check waypipe
# TODO: check gamescope on nvidia
