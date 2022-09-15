#!/bin/bash
if [ $# -ne 4 ] || !(echo "$1$2$3$4" | grep -qE '^([1-6]){4}$') || [[ $1 -eq $2 || $3 -eq $4 ]]
then
./usage.sh
else
./report.sh $1 $2 $3 $4
fi