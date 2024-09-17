#!/bin/bash

list="schedule.txt"

if [ ! -f "$list" ]; then
    touch "$list"
fi

while true; 

do
    read -p "Enter name: " name

    read -p "Enter shift (morning/mid/midnight): " shift
 
    read -p "Enter team (a1, a2, a3, b1, b2, b3): " team

    echo "Shift Created!"
    echo "$name $shift $team" >> "$list" || continue

done 
