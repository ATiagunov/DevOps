#!/bin/bash

res=0
echo
echo "Check no such file or directory"

str1=$(cat Null ../../test_files/*.txt)
str2=$(./s21_cat Null ../../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "   No file or dir: passed"
else
echo "   No file or dir: failed"
echo "GNU cat output:"
echo $str1
echo "s21_cat output:"
echo $str2
res=1

fi


echo
echo "Start single option tests"
str1=$(cat ../test_files/*.txt)
str2=$(./s21_cat ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "         no flags: passed"
else 
echo "         no flags: failed"
echo "GNU cat output:"
echo $str1
echo "s21_cat output:"
echo $str2
res=1

fi



str1=$(cat -b ../test_files/*.txt)
str2=$(./s21_cat -b ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "                b: passed"
else 
echo "                b: failed"
echo "GNU cat output:"
echo $str1
echo "s21_cat output:"
echo $str2
res=1

fi



str1=$(cat --number-nonblank ../test_files/*.txt)
str2=$(./s21_cat --number-nonblank ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "--number-nonblank: passed"
else 
echo "--number-nonblank: failed"
echo "GNU cat output:"
echo $str1
echo "s21_cat output:"
echo $str2
res=1

fi



str1=$(cat -e ../test_files/*.txt)
str2=$(./s21_cat -e ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "                e: passed"
else 
echo "                e: failed"
echo "GNU cat output:"
echo $str1
echo "s21_cat output:"
echo $str2
res=1

fi



str1=$(cat -E ../test_files/*.txt)
str2=$(./s21_cat -E ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "                E: passed"
else 
echo "                E: failed"
echo "GNU cat output:"
echo $str1
echo "s21_cat output:"
echo $str2
res=1

fi



str1=$(cat -n ../test_files/*.txt)
str2=$(./s21_cat -n ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "                n: passed"
else 
echo "                n: failed"
echo "GNU cat output:"
echo $str1
echo "s21_cat output:"
echo $str2
res=1

fi



str1=$(cat --number ../test_files/*.txt)
str2=$(./s21_cat --number ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "         --number: passed"
else 
echo "         --number: failed"
echo "GNU cat output:"
echo $str1
echo "s21_cat output:"
echo $str2
res=1

fi



str1=$(cat -s ../test_files/*.txt)
str2=$(./s21_cat -s ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "                s: passed"
else 
echo "                s: failed"
echo "GNU cat output:"
echo $str1
echo "s21_cat output:"
echo $str2
res=1

fi



str1=$(cat --squeeze-blank ../test_files/*.txt)
str2=$(./s21_cat --squeeze-blank ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "  --squeeze-blank: passed"
else 
echo "  --squeeze-blank: failed"
echo "GNU cat output:"
echo $str1
echo "s21_cat output:"
echo $str2
res=1

fi



str1=$(cat -t ../test_files/*.txt)
str2=$(./s21_cat -t ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "                t: passed"
else 
echo "                t: failed"
echo "GNU cat output:"
echo $str1
echo "s21_cat output:"
echo $str2
res=1

fi



str1=$(cat -T ../test_files/*.txt)
str2=$(./s21_cat -T ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "                T: passed"
else 
echo "                T: failed"
echo "GNU cat output:"
echo $str1
echo "s21_cat output:"
echo $str2
res=1

fi



str1=$(cat -T ../test_files/*.txt)
str2=$(./s21_cat -T ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "                T: passed"
else 
echo "                T: failed"
echo "GNU cat output:"
echo $str1
echo "s21_cat output:"
echo $str2
res=1

fi

echo

echo "          Start mix tests"
str1=$(cat -E -n -s ../test_files/*.txt)
str2=$(./s21_cat -E -n -s ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "         -E -n -s: passed"
else 
echo "         -E -n -s: failed"
echo "GNU cat output:"
echo $str1
echo "s21_cat output:"
echo $str2
res=1

fi



str1=$(cat -E -n ../test_files/*.txt)
str2=$(./s21_cat -E -n ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "            -E -n: passed"
else 
echo "            -E -n: failed"
echo "GNU cat output:"
echo $str1
echo "s21_cat output:"
echo $str2
res=1

fi



str1=$(cat -n -b ../test_files/*.txt)
str2=$(./s21_cat -n -b ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "            -n -b: passed"
else 
echo "            -n -b: failed"
echo "GNU cat output:"
echo $str1
echo "s21_cat output:"
echo $str2
res=1

fi



str1=$(cat -E  ../test_files/*.txt -n -s)
str2=$(./s21_cat -E ../test_files/*.txt -n -s)
if [ "$str1" == "$str2" ]
then
echo "         -E -n -s: passed"
else 
echo "         -E -n -s: failed"
echo "GNU cat output:"
echo $str1
echo "s21_cat output:"
echo $str2
res=1

fi


str1=$(cat -E -z ../test_files/*.txt -n -s)
str2=$(./s21_cat -E -z ../test_files/*.txt -n -s)
if [ "$str1" == "$str2" ]
then
echo "      -E -z -n -s: passed"
else 
echo "      -E -z -n -s: failed"
echo "GNU cat output:"
echo $str1
echo "s21_cat output:"
echo $str2
res=1

fi

echo
if [ $res -eq 0 ]
then
echo "         All tests passed"
else 
echo "            Error occured"
exit 1
fi
