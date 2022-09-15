#!/bin/bash

echo "Total number of folders (including all nested ones) = $(find $1 -type d| wc -l)"
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
du -h ${1} | sort -rh | head -n 5 | awk '{ print FNR " - " $2 ", "  substr($1, 1, length($1)-1) " " substr($1, length($1),length($1)) "b"}'
echo "Total number of files = $(find $1 -type f| wc -l)"
echo "Number of:"
echo "Configuration files = $(find $1 -name "*.conf" | wc -l)" 
echo "Text files = $(find $1 -name "*.txt" -o -name "*.doc" -o -name "*.docx" -o -name "*.rtf" -o -name "*.err" -o -name "*.text"| wc -l)"
echo "Executable files = $(find $1 -executable -type f| wc -l) "
echo "Log files = $(find $1 -name "*.log" | wc -l)"
echo "Archive files =  $(find $1 -name "*.7z" -o -name "*.cab" -o -name "*.deb" -o -name "*.gz" -o -name "*.rar" -o -name "*.zip"| wc -l)"
echo "Symbolic links = $(find $1 -type l | wc -l)"
echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
find ${1} -type f -exec du -h {} + | sort -rh | head -n 10 | awk '{ n = split($2,arr,"."); print FNR " - " $2 ", " substr($1, 1, length($1)-1) " " substr($1, length($1),length($1)) "b, " arr[n] }'
echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file)"  
./top10exe.sh $1