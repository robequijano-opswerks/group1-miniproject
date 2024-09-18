#!/bin/bash

list="schedule.txt"

if [ ! -f "$list" ]; then
    touch "$list"
fi

shift_time() {
    shift=$1
    case $shift in
        morning)
            echo "6am-3pm"
            ;;
        mid)
            echo "2pm-11pm"
            ;;
        midnight)
            echo "10pm-7am"
            ;;
    esac
}

display_schedule() {
    if [ ! -s "$list" ]; then
        echo "No data available."
    else
        team=$(awk '{print $3}' "$list" | sort | uniq)

        for team in $team; do
            echo "$team"
            grep " $team$" "$list" | while read -r line; do
                name=$(echo "$line" | awk '{print toupper(substr($1,1,1)) tolower(substr($1,2))}')
            	shift=$(echo "$line" | awk '{print tolower($2)}')
                time=$(shift_time "$shift")
                echo "   $name, $shift, $time"
	    done
        done
    fi
}

shift_full() {
    team=$1
    shift=$2
    count=$(grep -c "$shift $team" "$list")
    if [ "$count" -ge 2 ]; then
        return 0
    else
        return 1
    fi
}

add_employee() {
    name=$1
    shift=$2
    team=$3

    if shift_full "$team" "$shift"; then
        echo "Error: $shift shift in group $team is already full."
        return 1
    else
        echo "$name $shift $team" >> "$list"
        echo "Shift created!"
        return 0
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

    add_employee "$name" "$shift" "$team" || continue

done 

