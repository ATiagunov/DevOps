#!/bin/bash

if [ $# -ne 0 ];then
./usage.sh
else
. config_processing.sh
../03/report.sh $bc1 $fc1 $bc2 $fc2
./report_config.sh $bc1 $fc1 $bc2 $fc2 $default
fi