#!/bin/bash
set -e

# https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/2619
# https://bbs.archlinux.org/viewtopic.php?id=292316
# pipewire-pulse cause random noise one used with usb audio output (in dock?)
# Various settigns which might help:
# https://forum.manjaro.org/t/howto-troubleshoot-crackling-in-pipewire/82442
# * Disable Suspend
# * mainly default.clock.allowed-rates = [ 44100 48000 ]
yay -S pipewire pipewire-audio sof-firmware also-firmware pipewire-pulse pipewire-jack pipewire-alsa wireplumber pavucontrol
systemctl --user enable pipewire
systemctl --user enable pipewire-pulse
systemctl --user enable wireplumber
systemctl --user restart pipewire
systemctl --user restart wireplumber
