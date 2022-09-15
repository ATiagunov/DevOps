#!/bin/bash

CPU_INFO=$(mpstat | tail -1)
CPU_SYS=$(echo $CPU_INFO | awk '{print $6}')
CPU_USR=$(echo $CPU_INFO | awk '{print $4}')
echo "mpstat_cpu_sys $CPU_SYS" > /var/www/node.export/index.html
echo "mpstat_cpu_usr $CPU_USR" >> /var/www/node.export/index.html

AVAIL_MEM=$(cat /proc/meminfo | awk 'NR == 2{print$2}')
echo "available_ram $AVAIL_MEM" >> /var/www/node.export/index.html

FREE_SPACE=$(df / | tail -1 | awk '{print $4}')
echo "df_available $FREE_SPACE" >> /var/www/node.export/index.html
