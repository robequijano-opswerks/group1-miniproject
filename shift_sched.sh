#!/bin/bash

list="schedule.txt"

if [ ! -f "$list" ]; then
    touch "$list"
fi

display_schedule() {
    if [ ! -s "$list" ]; then
        echo "No data available."
    else
        team=$(awk '{print $3}' "$list" | sort | uniq)

        for team in $team; do
            echo "$team"
            grep " $team$" "$list" | while read -r line; do
                name=$(echo "$line" | awk '{print toupper(substr($1,1,1)) tolower(substr($1,2))}')
                shift=$(echo "$line" | awk '{print toupper(substr($2,1,1)) tolower(substr($2,2))}')
                echo "   $name, $shift"
            done
        done
    fi
}

while true; 

do
    read -p "Enter name: " name

    if [ "$name" == "print" ]; then
        display_schedule
        exit 0
    fi

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
