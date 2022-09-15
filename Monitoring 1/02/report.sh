#!/bin/bash

ram=$(../02/ram.sh)
root=$(../02/root.sh)

echo "HOSTNAME =" $(hostname)
echo "TIMEZONE =" $(timedatectl show -p Timezone --value) $(date +%Z -u) $(date +%Z)
echo "USER =" $(whoami)
echo "OS =" $(uname -o) $(hostnamectl | grep O | awk '{print $3 " " $4}')
echo "DATE =" $(date "+%d %b %Y %H:%M:%S")
echo "UPTIME =" $(uptime -p)
echo "UPTIME_SEC =" $(ps -eo pid,comm,etimes | grep -i "systemd" | head -1 | awk '{print $3}')
echo "IP =" $(ifconfig | grep netmask | head -1 | awk '{print $2}')
echo "MASK =" $(ifconfig | grep netmask | head -1 | awk '{print $4}')
echo "GATEWAY =" $(ip route | head -1 | awk '{print $3}')
echo "RAM_TOTAL = $(echo $ram | awk '{print $1}') GB"
echo "RAM_USED = $(echo $ram | awk '{print $2}') GB"
echo "RAM_FREE = $(echo $ram | awk '{print $3}') GB"
echo "SPACE_ROOT = $(echo $root | awk '{print $1}') MB"
echo "SPACE_ROOT_USED = $(echo $root | awk '{print $2}') MB"
echo "SPACE_ROOT_FREE = $(echo $root | awk '{print $3}') MB"