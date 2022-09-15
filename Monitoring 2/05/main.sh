#!/bin/bash

NUM_RANGE="^[1-4]$"
OK_CODE=" 20[01] "

if [ $# -eq 1 ] && [[ "$1" =~ $NUM_RANGE ]]; then

    LOG_PATH="../04/logs"
    if [ ! -d $LOG_PATH ]; then
        ../04/main.sh
        mv ./logs ../04/logs
    fi

    case $1 in  
    "1" ) cat $LOG_PATH/*.log | sort -k8;;
    "2" ) cat $LOG_PATH/*.log | awk '{print$1}'| uniq;;
    "3" ) cat $LOG_PATH/*.log | grep -ve $OK_CODE;;
    "4" ) cat $LOG_PATH/*.log | grep -ve $OK_CODE | awk '{print$1}' | uniq;;
    esac
else
 echo "The script is run with 1 parameter(1 - 4) with the following output:
  1 - All entries are sorted by response code
  2 - All unique IPs found in the entries
  3 - All requests with errors (response code - 4xx or 5xxx)
  4 - All unique IPs found among the erroneous requests" > /dev/stderr
fi

