#!/usr/bin/env bash
# https://www.nerdfonts.com/cheat-sheet
# https://github.com/ryanoasis/nerd-fonts#glyph-sets


bat_stat=$(upower -i $(upower -e | grep BAT) | grep -i "state:\|percentage\|time to" | tr -s " ")

echo "Battery info:" >&2
echo "$bat_stat" >&2


percent=$(grep -o "[0-9]*%" <<< $bat_stat)
status="?"
if [[ ${percent%\%} -le '10' ]]; then
    status=" "
elif [[ ${percent%\%} -ge '11' ]] && [[ ${percent%\%} -le '25'  ]]; then
    status=" "
elif [[ ${percent%\%} -ge '26' ]] && [[ ${percent%\%} -le '50'  ]]; then
    status=" "
elif [[ ${percent%\%} -ge '51' ]] && [[ ${percent%\%} -le '75'  ]]; then
    status=" "
elif [[ ${percent%\%} -ge '76' ]] && [[ ${percent%\%} -le '100'  ]]; then
    status=" "
fi

if [[ ! -z $(grep " charging" <<< $bat_stat) ]];then 
   status="$status "
fi

echo "$status - $percent"
