#!/bin/bash

RC=0

is_num="^[0-9]+$"
duplicate="([a-zA-Z]).*\1"
file_ext="^([a-zA-Z]){1,7}\.([a-zA-Z]){1,3}$"
eqless100_kb="^([1-9][0-9]?|100|0)kb$"

if [ $# -ne 6 ]; then
  echo "Invalid input: number of arguments should be 6" > /dev/stderr
  RC=1
elif [[ "${$1:0:1}" != / && "${$1:0:2}" != ~[/a-z] ]]; then
  echo "Invalid input: arg1 should be absolute path" > /dev/stderr
  RC=2
elif [[ !("$2" =~ $is_num) ]]; then
  echo "Invalid input: arg2 should be positive number" > /dev/stderr
  RC=3
elif [[ ${#$3} -gt 7 || "$3" =~ $duplicate ]]; then
  echo "Invalid input: arg3 should contain no more than 7 unique characters" > /dev/stderr
  RC=4
elif [[ !("$4" =~ $is_num) ]]; then
  echo "Invalid input: arg4 should be positive number" > /dev/stderr
  RC=5
elif [[ !("$5" =~ $file_ext) ]]; then
  echo "Invalid input: arg5 should contain no more than 7 characters for the name and 3 unique chars for the extension" > /dev/stderr
  RC=6
elif [[ !("$6" =~ $eqless100_kb) ]]; then
  echo "Invalid input: arg6 size in kb no more than 100" > /dev/stderr
  RC=7
fi

if [ $RC -eq 0 ]; then

  generate () {
    NUM=$1
    LETTERS=$2
    MIN_LEN=4

    # Hash table to store letters and their count for each name
    declare -A LETTER_COUNTER

    if [ "${#LETTERS}" -lt "$MIN_LEN" ]; then
    CURR_LEN=$MIN_LEN
    else
    CURR_LEN=${#LETTERS}
    fi

    resetHashTable () {

      for ((i = 1; i < ${#LETTERS}; ++i)); do
        CHAR=${LETTERS:$i:1}
        LETTER_COUNTER[$CHAR]=1
      done

      FIRST=${LETTERS:0:1}
      if [ ${#LETTERS} -lt $CURR_LEN ]; then
      LETTER_COUNTER[$FIRST]=$(($CURR_LEN - ${#LETTERS} + 1))
      else
        LETTER_COUNTER[$FIRST]=1
      fi
    }

    #Repeat some operation $1 times
    repeat () {
      for ((i = 0; i < $1; ++i)); do
        eval ${*:2}
      done
    }

    resetHashTable
    CHAR_ID=0
    CURR_CHAR=${LETTERS:$CHAR_ID:1}
    NEXT_CHAR=${LETTERS:$(($CHAR_ID + 1)):1}
    for ((COUNT = 0; COUNT < $NUM; ++COUNT)); do
      NAME=""
      START=0
      for ((i = 0; i < ${#LETTERS}; ++i)); do
        KEY=${LETTERS:$i:1}
        NAME+=$(repeat ${LETTER_COUNTER[$KEY]} echo -n $KEY)
      done

      [ $COUNT -eq 0 ] && echo -n "$NAME" || echo -n " $NAME"

      # if occurences of the current letter is 1 -> change letters
      while [[ ${LETTER_COUNTER[$CURR_CHAR]} -eq 1 && $COUNT -lt $((NUM - 1)) ]]; do

        ((++CHAR_ID))

        # if it was second to last letter we should increase the length and reset hashtable
        if [[ $(($CHAR_ID + 1)) -eq ${#LETTERS} ]]; then
          ((++CURR_LEN))
          CHAR_ID=0
          resetHashTable
          START=1
        fi

        CURR_CHAR=${LETTERS:$CHAR_ID:1}
        NEXT_CHAR=${LETTERS:$(($CHAR_ID + 1)):1}
      done

      if [ $START -ne 1 ]; then
        LETTER_COUNTER[$CURR_CHAR]=$((${LETTER_COUNTER[$CURR_CHAR]} - 1))
        LETTER_COUNTER[$NEXT_CHAR]=$((${LETTER_COUNTER[$NEXT_CHAR]} + 1))
      fi
    done
  }

  FOLDERS=$(generate $2 $3)

  FILES_EXT_AR=(${5//./ })
  FILES=$(generate $4 ${FILES_EXT_AR[0]})

  FOLDERS_AR=(${FOLDERS})
  FILES_AR=(${FILES})

  if [ ! -d "$1" ];then
    mkdir "$1"
  fi
  DATE=$(date +"%d.%m.%Y")

  FREE_GB=$( df -BG / | tail -1 | awk '{print substr($4, 1, length($4)-1)}' )
  for ((i = 0, j = 0; i < $2 && $(( $FREE_GB > 0 )); ++i, j = 0)); do
    DIR="$1/${FOLDERS_AR[i]}"
    mkdir -m 777 $DIR
    while [ $FREE_GB -gt 0 ] && [ "$j" -lt "$4" ]; do
      dd if=/dev/zero of="$DIR/${FILES_AR[j]}_$DATE.${FILES_EXT_AR[1]}"  bs=1K  count=`echo "$6" | sed 's/kb//'`
      echo "$DIR/${FILES_AR[j]}_$DATE.${FILES_EXT_AR[1]}  $DATE  "$6"" >> part1.log
      FREE_GB=$( df -BG / | tail -1 | awk '{print substr($4, 1, length($4)-1)}' )
      (( ++j ))
    done

  done

else
  echo "The script is run with 6 parameters. An example of running a script:

  /main.sh /opt/test 4 az 5 az.az 3kb

  Parameter 1 is the absolute path. 
  Parameter 2 is the number of subfolders. 
  Parameter 3 is a list of English alphabet letters used in folder names
  (no more than 7 characters). 
  Parameter 4 is the number of files in each created folder. 
  Parameter 5 - the list of English alphabet letters used in the file name and extension
  (no more than 7 characters for the name, no more than 3 characters for the extension). 
  Parameter 6 - file size (in kilobytes, but not more than 100)." > /dev/stderr
  exit $RC
fi
