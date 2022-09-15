#!/bin/bash

echo -e "\nInvalid input.\nThe script is run with 4 numeric parameters from 1 to 6."
echo "Colour designations: (1 - white, 2 - red, 3 - green, 4 - blue, 5 - purple, 6 - black)"
echo "Parameter 1 is the background of the value names (HOSTNAME, TIMEZONE, USER etc.)"
echo "Parameter 2 is the font colour of the value names (HOSTNAME, TIMEZONE, USER etc.)"
echo "Parameter 3 is the background of the values (after the '=' sign)"
echo "Parameter 4 is the font colour of the values (after the '=' sign)"
echo -e "\nThe font and background colours of one column must not match."

echo -e "\nDo you want to run the script again? [Y/n]"
read var1
if [ $var1 == "Y" ] || [ $var1 == "y" ]
then
echo -n "./main.sh "
read var2
./main.sh $var2
else
echo "Abort."
fi
