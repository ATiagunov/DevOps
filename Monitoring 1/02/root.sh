#!/bin/bash

all=$(df / -BK| tail -1 )
total=$(bc<<<"scale=2;$(echo $all | awk '{print $2}')/1000")
used=$(bc<<<"scale=2;$(echo $all | awk '{print $3}')/1000")
free=$(bc<<<"scale=2;$(echo $all | awk '{print $4}')/1000")
echo "$total $used $free"