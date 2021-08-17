#!/usr/bin/env bash

# fix opacity when restarting compton. Stacked / tabbed windows keep _NET_WM_WINDOW_OPACITY = 0 which cause 
# completly hidden windows. Fix is to remove opacity parameter using xprop.

for w in `wmctrl -l | awk '{print $1}'`; do xprop_w="`xprop -id $w`" ; grep "_NET_WM_STATE_HIDDEN" -q <<< $xprop_w && grep "_NET_WM_WINDOW_OPACITY" -q <<< $xprop_w && xprop -id $w -remove "_NET_WM_WINDOW_OPACITY"; done
