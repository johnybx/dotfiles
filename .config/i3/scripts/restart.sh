#!/usr/bin/env bash

if [[ -z $1 ]]; then
    echo "need at least one parameter application!"
fi

timeout=15
pkill -9 $1
x=0
# just make sure we don't do infinity loops
while [[ -n $(pgrep $1) ]] && [[ ! $x -ge $timeout ]]; do sleep 0.1; x=$(($x+1)) ; done

$@
