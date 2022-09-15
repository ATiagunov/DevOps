#!/bin/bash

./report.sh
echo "Do you want to write the data to a file? [Y/n]"
read w_file
if [ $w_file == "Y" ] || [ $w_file == "y" ]
then
./report.sh > $(date +%d_%m_%Y_%H_%M_%S).status
fi