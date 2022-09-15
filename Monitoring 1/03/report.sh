#!/bin/bash


case $1 in
    1 ) bc1=47 ;;
    2 ) bc1=41 ;;
    3 ) bc1=42 ;;
    4 ) bc1=44 ;;
    5 ) bc1=45 ;;
    6 ) bc1=40 ;;
esac

case $2 in
    1 ) fc1=37 ;;
    2 ) fc1=31 ;;
    3 ) fc1=32 ;;
    4 ) fc1=34 ;;
    5 ) fc1=35 ;;
    6 ) fc1=30 ;;
esac

case $3 in
    1 ) bc2=47 ;;
    2 ) bc2=41 ;;
    3 ) bc2=42 ;;
    4 ) bc2=44 ;;
    5 ) bc2=45 ;;
    6 ) bc2=40 ;;
esac

case $4 in
    1 ) fc2=37 ;;
    2 ) fc2=31 ;;
    3 ) fc2=32 ;;
    4 ) fc2=34 ;;
    5 ) fc2=35 ;;
    6 ) fc2=30 ;;
esac

scheme1="\033[$(echo "$bc1");$(echo "$fc1")m"
scheme2="\033[$(echo "$bc2");$(echo "$fc2")m"
end="\033[0m"

readarray -t report <<<"$(../02/report.sh)"
for i in {0..15}
do
   line=${report[i]}
   echo -en "$scheme1"
   first=0
   for token in $line
   do
   if [ $first -eq 0 ]; then
   echo -en "$token";first=1
   elif [ "$token" = "=" ]; then
   echo -en "$end $token $scheme2";first=0
   else
   echo -en " $token"
   fi
   done
   echo -e $end
done
