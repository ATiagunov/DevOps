#!/bin/bash

RC=0

duplicate="([a-zA-Z]).*\1"
file_ext="^([a-zA-Z]){1,7}\.([a-zA-Z]){1,3}$"
eqless100_mb="^([1-9][0-9]?|100|0)Mb$"
FOLDER_CHARS=$1 

if [ $# -ne 3 ]; then
  echo "Invalid input: number of arguments should be 3"
  RC=1
elif [[ ${#FOLDER_CHARS} -gt 7 || "$1" =~ $duplicate ]]; then
  echo "Invalid input: arg1 should contain no more than 7 unique characters"
  RC=2
elif [[ !("$2" =~ $file_ext) ]]; then
  echo "Invalid input: arg2 should contain no more than 7 characters for the name and 3 unique chars for the extension"
  RC=3
elif [[ !("$3" =~ $eqless100_mb) ]]; then
  echo "Invalid input: arg3 size in Mb no more than 100"
  RC=4
fi

if [ $RC -eq 0 ]; then

  generate () {
    NUM=100
    LETTERS=$1
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

  START_TIME=$(date +"%T")
  FILES_EXT_AR=(${2//./ })
  FOLDERS=$(generate $1)
  FILES=$(generate ${FILES_EXT_AR[0]})
  FOLDERS_AR=(${FOLDERS})
  FILES_AR=(${FILES})

  DATE=$(date +"%d.%m.%Y")

  BASE=$(find / -maxdepth 2 -type d -perm /a=w | grep -ve "\/s\?bin")
  BASE_AR=(${BASE})
  BASE_AR_LEN=$((${#BASE_AR[@]} - 1))

  FREE_GB=$( df -BG / | tail -1 | awk '{print substr($4, 1, length($4)-1)}' )
  
  for ((i = 0; i < 100 && $(( $FREE_GB > 1 )); ++i)); do
    DIR="${BASE_AR[$(shuf -i 0-$BASE_AR_LEN -n 1)]}/${FOLDERS_AR[i]}_$DATE"
    mkdir -m 777 $DIR
    NUM_FILES=$(shuf -i 0-100 -n 1)

    for ((j = 0; j < $NUM_FILES && $(( $FREE_GB > 1 )); ++j)); do
      dd if=/dev/zero of="$DIR/${FILES_AR[j]}_$DATE.${FILES_EXT_AR[1]}"  bs=1M  count=`echo "$3" | sed 's/Mb//'`
      echo "$DIR/${FILES_AR[j]}_$DATE.${FILES_EXT_AR[1]}  $DATE  "$3"" >> part2.log
      FREE_GB=$( df -BG / | tail -1 | awk '{print substr($4, 1, length($4)-1)}' )    
    done

  done
  END_TIME=$(date +"%T")
  echo "Started: $DATE $START_TIME"
  echo "Completed: $DATE $END_TIME"
  START_TIME=$(date -u -d "$START_TIME" +"%s")
  END_TIME=$(date -u -d "$END_TIME" +"%s")
  date -u -d "0 $END_TIME sec - $START_TIME sec" +"%H:%M:%S"

else
  echo "The script is run with 3 parameters. An example of running a script:

  ./main.sh az az.az 100Mb
 
  Parameter 1 is a list of English alphabet letters used in folder names
  (no more than 7 characters). 
  Parameter 2 - the list of English alphabet letters used in the file name and extension
  (no more than 7 characters for the name, no more than 3 characters for the extension). 
  Parameter 3 - file size (in megabytes, but not more than 100)." > /dev/stderr
  exit $RC
fi

