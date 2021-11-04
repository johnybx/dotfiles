#!/bin/bash
while [[ $# -gt 0 ]]
do
key="$1"
case $key in
    -l|--lib)
    LIBVIRT="1"
    shift # past argument=value
    ;;
    -b|--bluetooth)
    BLUETOOTH="1"
    shift
    ;;
    -o|--only)
    ONLY="1"
    shift
    ;;
    -n|--network)
    NETWORK="1"
    shift
    ;;
    *)
    shift      # unknown option
    ;;
esac
done

if [[ -z $ONLY ]]; then
    setxkbmap -option caps:escape
    #alsactl init
    i3-msg 'exec --no-startup-id  /usr/bin/thunderbird'
    i3-msg 'exec --no-startup-id  /usr/bin/slack'
    # i3-msg 'exec --no-startup-id  /usr/bin/boostnote'
    # i3-msg 'exec --no-startup-id  /usr/bin/code-insiders'
    i3-msg 'exec --no-startup-id  /usr/bin/kitty --execute tmux'
    i3-msg 'exec --no-startup-id  /usr/bin/firefox'
fi

if [[ ! -z $LIBVIRT ]] && [[ $LIBVIRT -eq 1  ]]; then
	sudo systemctl start libvirtd
	i3-msg 'exec --no-startup-id  /usr/bin/virt-manager'
fi

if [[ ! -z $BLUETOOTH ]] && [[ $BLUETOOTH -eq 1  ]]; then
    sudo modprobe btusb
    sudo modprobe btrtl
    sudo modprobe btbcm
    sudo modprobe btintel
    sudo modprobe bluetooth
    sudo systemctl start bluetooth
    sudo rfkill unblock bluetooth
fi
if [[ ! -z $NETWORK ]] && [[ $NETWORK -eq 1  ]]; then
    sudo ip link set dev wlp0s20f3 up
    sudo wpa_supplicant -B -c /etc/wpa_supplicant/wpa_supplicant.conf -i wlp0s20f3
    sudo dhclient wlp0s20f3
fi
