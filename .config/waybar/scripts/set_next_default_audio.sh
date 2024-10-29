#!/bin/bash

# First argument is match string from output of wpctl -> either "Sources" or "Sinks" ( might work
# also for others )

type="Sources"
if [[ -n $1 ]]; then
    type=$1
fi

mapfile -t OPTIONS < <(wpctl status | awk '/Audio/' RS="\n\n" ORS="\n\n" | awk "/$type:/" RS="\n[[:blank:]]+[[:graph:]][[:blank:]]+\n" ORS="\n" | grep -Eo "\*?\s+[0-9]+\.\s+" | tr -d " .")

for i in "${!OPTIONS[@]}"
do
    if [[ "${OPTIONS[$i]}" =~ ^\*[0-9]+$ ]]; then
        wpctl set-default "${OPTIONS[(( ($i + 1 ) % ${#OPTIONS[@]} ))]}"
        break
    fi
   
done
