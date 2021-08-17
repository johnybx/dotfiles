#!/usr/bin/env bash

if [[ $DESKTOP_SESSION == 'i3' ]] && [[ $XDG_CURRENT_DESKTOP == 'i3' ]]; then
    /usr/bin/i3lock-fancy -p -g
fi

