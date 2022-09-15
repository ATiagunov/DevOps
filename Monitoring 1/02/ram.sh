#!/bin/bash

all=$(free --mega | grep Mem )
total=$(bc<<<"scale=3;$(echo $all | awk '{print $2}')/1000")
used=$(bc<<<"scale=3;$(echo $all | awk '{print $3}')/1000")
free=$(bc<<<"scale=3;$(echo $all | awk '{print $4}')/1000")
echo "$total $used $free"