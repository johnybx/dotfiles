#!/bin/bash

SOURCES=$(wpctl status | awk '/Audio/' RS="\n\n" ORS="\n\n" | awk '/Sources:/' RS="\n[[:blank:]]+[[:graph:]][[:blank:]]+\n" ORS="\n")
INFO=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)
VOLUME="$(echo "$INFO"|awk '{print int($2 * 100)}')"
ICON="\uf130"
if  grep "MUTED" -q <<< "$INFO" ; then
    ICON="\uf131"
fi

echo -n "{\"text\": \"$VOLUME% $ICON\", \"alt\": \"\", \"tooltip\": $(echo "$SOURCES" | jq -Rsa), \"class\": \"microphone-audio\", \"percentage\": $VOLUME }"
