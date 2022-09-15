#!/bin/bash

LOG_PATH="./logs"
if [ ! -d "$LOG_PATH" ]; then
`mkdir -p $LOG_PATH`;
fi

#Init log data
IP=0.0.0.0
STATUS_CODE=(200 201 400 401 403 404 500 501 502 503)
METHOD=("GET" "POST" "PUT" "PATCH" "DELETE")
#Create 6 random dates from '2022-02-24' to '2022-08-22'
#08/22/2022 02:59
DATE_AR=(`shuf -n6 -i$(date -d '2022-02-24' '+%s')-$(date -d '2022-08-22' '+%s') | xargs -I{} date -d '@{}' '+%m/%d/%Y'`)
USER_AGENT=("Mozilla" "Google Chrome" "Opera" "Safari" "Internet Explorer" "Microsoft Edge" "Crawler and bot" "Library and net tool")


for (( cur_log=1; cur_log < 6 ; ++cur_log )); do
    #Generate num of entries per each log
    NUM_LINES=$(shuf -i 100-1000 -n 1)
    HOUR=$(shuf -i 0-23 -n 1)
    MIN=$(shuf -i 0-40 -n 1)
    SEC=$(shuf -i 0-59 -n 1)
    COUNT_SAME_SEC=$(shuf -i 1-5 -n 1)
    for (( i=0, curr_sec=0; i < "$NUM_LINES" ; ++i, ++curr_sec )); do
        #Generate ip address
        IP=$(printf "%d.%d.%d.%d\n" "$((RANDOM % 256))" "$((RANDOM % 256))" "$((RANDOM % 256))" "$((RANDOM % 256))")
        
        #Generate number of transfered bytes
        NUM_BYTES=$(shuf -i 400-10000 -n 1)

        #Generate URL by UUID generator
        URL=$(cat /proc/sys/kernel/random/uuid | sed 's/[-]//g' | head -c 10)
        if [ $curr_sec -eq $COUNT_SAME_SEC ];then
            (( ++SEC ))
            curr_sec=0
            COUNT_SAME_SEC=$(shuf -i 1-5 -n 1)
            if [ $SEC -eq 60 ];then
                SEC=0
                (( ++MIN ))
            fi
        fi

        if [ $HOUR -lt 10 ];then
            ZERO_HOUR="0$HOUR"
        else
            ZERO_HOUR="$HOUR"
        fi

        if [ $MIN -lt 10 ];then
            ZERO_MIN="0$MIN"
        else
            ZERO_MIN="$MIN"
        fi

        DATE_TIME=$(date -d "${DATE_AR[$cur_log]} $ZERO_HOUR:$ZERO_MIN:$SEC" '+%d/%B/%Y:%T')
        echo "$IP - - [$DATE_TIME] \"${METHOD[$RANDOM%5]} / HTTP/1.1\" ${STATUS_CODE[$RANDOM%10]} $NUM_BYTES \"http://$URL.html\" \"${USER_AGENT[$RANDOM%8]}\"" >> "$LOG_PATH/access_$cur_log.log"

    done
done