#!/bin/bash
/usr/bin/powertop --auto-tune
for i in $(ls /sys/bus/usb/drivers/usbhid | grep -oE '^[0-9]+-[0-9\.]+' | sort -u); do
    echo -n "Enabling " | cat - /sys/bus/usb/devices/$i/product;
    echo 'on' > /sys/bus/usb/devices/$i/power/control;
done
