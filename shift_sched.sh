#!/bin/bash

list="schedule.txt"

if [ ! -f "$list" ]; then
    touch "$list"
fi

while true; 

do
    read -p "Enter name: " name

    read -p "Enter shift (morning/mid/midnight): " shift
    if ! [[ "$shift" =~ ^(morning|mid|midnight)$ ]]; then
        echo "Invalid shift. Available shifts: 'morning' 'mid' 'midnight'"
        continue
    fi

    read -p "Enter team (a1, a2, a3, b1, b2, b3): " team
    if ! [[ "$team" =~ ^(a1|a2|a3|b1|b2|b3)$ ]]; then
        echo "Invalid team. Available team 'a1' 'a2' 'a3' 'b1' 'b2' 'b3'"
        continue
    fi

    echo "Shift Created!"
    echo "$name $shift $team" >> "$list" || continue

done 
