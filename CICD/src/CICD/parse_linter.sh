#!/bin/bash

cd ../cat
make check > output.txt
result=$(grep 'errors' output.txt)
rm output.txt
if [ ! -z "$result" ]
then
exit 1
fi

cd ../grep
make check > output.txt
result=$(grep 'errors' output.txt)
rm output.txt
if [ -z "$result" ]
then
exit 0
else
exit 1
fi
