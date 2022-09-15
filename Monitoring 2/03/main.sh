#!/bin/bash

RC=0

if [ $# -ne 1 ]; then
  echo "Invalid input: number of arguments should be 1" > /dev/stderr
  RC=1
elif [[ $1 -lt 1 || $1 -gt 3 ]]; then
  echo "Invalid input: argument should be a number in range of 1 to 3 inclusively" > /dev/stderr
  RC=2
fi

if [ $RC -eq 0 ]; then

  if [[ "$1" -eq 1 ]]; then
    LIST=$(cat ../02/part2.log | grep -o '^[\/]\S*\/'| sort | uniq)
    rm -rf $LIST
  elif [[ "$1" -eq 2 ]]; then

    date_time="^(0[1-9]|1[012])\/(0[1-9]|[12][0-9]|3[01])\/(19\d{2}|20[01][0-9]|202[012])\s+(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$"
    
    echo "Enter starting date and time (e.g. 08/22/2022 02:32)"
    read start_date_time
    if [[ !("$start_date_time" =~ $date_time) ]]; then
      echo "Incorrect starting date and time input" > /dev/stderr
      echo "$start_date_time"
      exit 3
    fi

    echo "Enter ending date and time (e.g. 08/22/2022 02:59)"
    read end_date_time
    if [[ !("$end_date_time" =~ $date_time) ]]; then
      echo "Incorrect ending date and time input" > /dev/stderr
      exit 4
    fi

    start_epoch=$(date -d "$start_date_time" +"%s")
    end_epoch=$(date -d "$end_date_time" +"%s")

    LIST=$(find / -maxdepth 3 -type d -perm 777 -exec stat -c'%n %Z' {} +)
    LIST_AR=(${LIST})
    LEN=${#LIST_AR[@]}
    for ((folder_i = 0, epoch_i = 1; folder_i < $LEN; folder_i += 2, epoch_i += 2)); do
      if [[ ${LIST_AR[epoch_i]} -lt $end_epoch && ${LIST_AR[epoch_i]} -gt $start_epoch ]];then
        rm -rf ${LIST_AR[folder_i]}
      fi
    done

  elif [[ $1 -eq 3 ]]; then
    mask="[a-z]*_[0-9][0-9].[0-9][0-9].[0-9][0-9][0-9][0-9]"
    find / -type d -perm 777 -name $mask -exec rm -rf {} + 
  fi

else
  echo "The script is run with 1 parameter to delete files in the following way:
  1. By log file
  2. By creation date and time
  3. By name mask (i.e. characters, underlining and date)." > /dev/stderr
  exit $RC
fi