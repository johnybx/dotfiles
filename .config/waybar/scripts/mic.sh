#!/bin/bash

INFO=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)
VOLUME="$(echo "$INFO"|awk '{print int($2 * 100)}')"
ICON="\uf130"
if  grep "MUTED" -q <<< "$INFO" ; then
    ICON="\uf131"
fi

echo -n "{\"text\": \"$VOLUME% $ICON\", \"alt\": \"\", \"tooltip\": $(wpctl inspect @DEFAULT_AUDIO_SOURCE@ | grep 'type\|node'  | jq -Rsa), \"class\": \"microphone-audio\", \"percentage\": $VOLUME }"
