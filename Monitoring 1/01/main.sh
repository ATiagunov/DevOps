#!/bin/bash

if [ $# -ne 1 ] || echo "$1" | grep -qE '^[+-]?[0-9]+([.][0-9]+)?$'
then
./usage.sh
else
echo "$1"
fi