#!/bin/bash

. config.conf

default=0

set_default(){
    echo -e "\nIncorrect config. Color scheme is set to default.\n"
    bc1=6
    fc1=1
    bc2=6
    fc2=1
    default=1
}

bc1=${column1_background:0}
fc1=${column1_font_color:0}
bc2=${column2_background:0}
fc2=${column2_font_color:0}

if !(echo "$bc1$fc1$bc2$fc2" | grep -qE '^([1-6]){4}$') || [[ $bc1 -eq $fc1 || $bc2 -eq $fc2 ]];then
    set_default
fi

