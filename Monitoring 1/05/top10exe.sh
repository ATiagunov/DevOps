#!/bin/bash

find ${1} -type f -executable -exec du -h {} + | sort -rh | head -n 10 | awk '{print FNR " - " $2 " , " substr($1, 1, length($1)-1) " " substr($1, length($1),length($1)) "b, " }' > temp.txt
cat temp.txt | while read line
do
echo -n "$line"
name="$(echo $line | awk '{print $3}')"
md5sum $name | awk '{ print " " $1}'
done
rm temp.txt