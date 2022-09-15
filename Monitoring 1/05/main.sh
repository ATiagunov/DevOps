#!/bin/bash

if [ $# -ne 1 ] || [ ! -d $1 ];then
./usage.sh
else
TIMEFORMAT="Script execution time (in seconds) %1R"
time {
./report.sh $1
}
fi
