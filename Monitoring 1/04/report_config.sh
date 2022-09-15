#!/bin/bash

print_color() {
    case $1 in
        1 ) echo "(white)" ;;
        2 ) echo "(red)" ;;
        3 ) echo "(green)" ;;
        4 ) echo "(blue)" ;;
        5 ) echo "(purple)" ;;
        6 ) echo "(black)" ;;
    esac
}

args=("$@")
prints=("\nColumn 1 background = " "Column 1 font color = " "Column 2 background = " "Column 2 font color = ")

for i in {0..3}
do
   echo -en "${prints[i]}"
   [ $5 -eq 0 ] && echo -n "${args[i]} " || echo -n "default "
   print_color ${args[i]}
done