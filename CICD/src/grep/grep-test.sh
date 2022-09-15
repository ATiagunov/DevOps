#!/bin/bash

res=0
echo
echo "Check no such file or directory"

str1=$(grep Null ../../test_files/*.txt)
str2=$(./s21_grep Null ../../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "   No file or dir: passed"
else 
echo "   No file or dir: failed"
echo "GNU grep output:"
echo $str1
echo "s21_grep output:"
echo $str2
res=1
fi

if [ $res -eq 0 ]
then
str1=$(grep -sf ../../test_files/pat.txt ../../test_files/txt1.txt)
str2=$(./s21_grep -sf ../../test_files/pat.txt ../../test_files/txt1.txt)
if [ "$str1" == "$str2" ]
then
echo "               -sf: passed"
else 
echo "               -sf: failed"
echo "GNU grep output:"
echo $str1
echo "s21_grep output:"
echo $str2
res=1
fi
fi

if [ $res -eq 0 ]
then
echo
echo "Start single option tests"
str1=$(grep ../test_files/*.txt)
str2=$(./s21_grep ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "       no options: passed"
else 
echo "       no options: failed"
echo "GNU grep output:"
echo $str1
echo "s21_grep output:"
echo $str2
res=1
fi
fi

if [ $res -eq 0 ]
then
str1=$(grep at ../test_files/*.txt)
str2=$(./s21_grep at ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "       plain text: passed"
else 
echo "       plain text: failed"
echo "GNU grep output:"
echo $str1
echo "s21_grep output:"
echo $str2
res=1
fi
fi

if [ $res -eq 0 ]
then
str1=$(grep -e ../test_files/*.txt)
str2=$(./s21_grep -e ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "        option -e: passed"
else 
echo "        option -e: failed"
echo "GNU grep output:"
echo $str1
echo "s21_grep output:"
echo $str2
res=1
fi
fi

if [ $res -eq 0 ]
then
str1=$(grep -e asdf ../test_files/*.txt)
str2=$(./s21_grep -e asdf ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "   option -e asdf: passed"
else 
echo "   option -e asdf: failed"
echo "GNU grep output:"
echo $str1
echo "s21_grep output:"
echo $str2
res=1
fi
fi

if [ $res -eq 0 ]
then
str1=$(grep -e ^A ../test_files/*.txt)
str2=$(./s21_grep -e ^A ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "     option -e ^A: passed"
else 
echo "     option -e ^A: failed"
echo "GNU grep output:"
echo $str1
echo "s21_grep output:"
echo $str2
res=1
fi
fi

if [ $res -eq 0 ]
then
str1=$(grep -e [^i*t] ../test_files/*.txt)
str2=$(./s21_grep -e [^i*t] ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo " option -e [^i*t]: passed"
else 
echo " option -e [^i*t]: failed"
echo "GNU grep output:"
echo $str1
echo "s21_grep output:"
echo $str2
res=1
fi
fi


if [ $res -eq 0 ]
then
str1=$(grep -f ../test_files/pat.txt ../test_files/*.txt)
str2=$(./s21_grep -f ../test_files/pat.txt ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo " option -f [^i*t]: passed"
else 
echo " option -f [^i*t]: failed"
echo "GNU grep output:"
echo $str1
echo "s21_grep output:"
echo $str2
res=1
fi
fi

if [ $res -eq 0 ]
then
str1=$(grep -f ../test_files/empty.txt ../test_files/*.txt)
str2=$(./s21_grep -f ../test_files/empty.txt ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "  option -f empty: passed"
else 
echo "  option -f empty: failed"
echo "GNU grep output:"
echo $str1
echo "s21_grep output:"
echo $str2
res=1
fi
fi

if [ $res -eq 0 ]
then
str1=$(grep -fs ../test_files/no_fl.txt ../test_files/*.txt)
str2=$(./s21_grep -fs ../test_files/no_fl.txt ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo " option -sf no_fl: passed"
else 
echo " option -sf no_fl: failed"
echo "GNU grep output:"
echo $str1
echo "s21_grep output:"
echo $str2
res=1
fi
fi

if [ $res -eq 0 ]
then
str1=$(grep -v at ../test_files/*.txt)
str2=$(./s21_grep -v at ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "        option -v: passed"
else 
echo "        option -v: failed"
echo "GNU grep output:"
echo $str1
echo "s21_grep output:"
echo $str2
res=1
fi
fi

if [ $res -eq 0 ]
then
str1=$(grep -i as ../test_files/abcde1.txt)
str2=$(./s21_grep -i as ../test_files/abcde1.txt)
if [ "$str1" == "$str2" ]
then
echo "        option -i: passed"
else 
echo "        option -i: failed"
echo "GNU grep output:"
echo $str1
echo "s21_grep output:"
echo $str2
res=1
fi
fi


if [ $res -eq 0 ]
then
str1=$(grep -h as ../test_files/*.txt)
str2=$(./s21_grep -h as ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "        option -h: passed"
else 
echo "        option -h: failed"
echo "GNU grep output:"
echo $str1
echo "s21_grep output:"
echo $str2
res=1
fi
fi

if [ $res -eq 0 ]
then
str1=$(grep -hl as ../test_files/*.txt)
str2=$(./s21_grep -hl as ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "       option -hl: passed"
else 
echo "       option -hl: failed"
echo "GNU grep output:"
echo $str1
echo "s21_grep output:"
echo $str2
res=1
fi
fi


if [ $res -eq 0 ]
then
str1=$(grep -c as ../test_files/*.txt)
str2=$(./s21_grep -c as ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "        option -c: passed"
else 
echo "        option -c: failed"
echo "GNU grep output:"
echo $str1
echo "s21_grep output:"
echo $str2
res=1
fi
fi

if [ $res -eq 0 ]
then
str1=$(grep -in 'a' ../test_files/abcde1.txt )
str2=$(./s21_grep -in 'a' ../test_files/abcde1.txt)
if [ "$str1" == "$str2" ]
then
echo "        option -n: passed"
else 
echo "        option -n: failed"
echo "GNU grep output:"
echo $str1
echo "s21_grep output:"
echo $str2
res=1
fi
fi

if [ $res -eq 0 ]
then
str1=$(grep -io a ../test_files/*.txt)
str2=$(./s21_grep -io a ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "        option -o: passed"
else 
echo "        option -o: failed"
echo "GNU grep output:"
echo $str1
echo "s21_grep output:"
echo $str2
res=1
fi
fi

if [ $res -eq 0 ]
then
echo
echo "Start mix option tests"
str1=$(grep -ihne go*gle ../test_files/regex.txt)
str2=$(./s21_grep -ihne go*gle ../test_files/regex.txt)
if [ "$str1" == "$str2" ]
then
echo "       mix with e: passed"
else 
echo "       mix with e: failed"
echo "GNU grep output:"
echo $str1
echo "s21_grep output:"
echo $str2
res=1
fi
fi


if [ $res -eq 0 ]
then
str1=$(grep -ivhne go*gle ../test_files/*.txt)
str2=$(./s21_grep -ivhne go*gle ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "   inv mix with e: passed"
else 
echo "   inv mix with e: failed"
echo "GNU grep output:"
echo $str1
echo "s21_grep output:"
echo $str2
res=1
fi
fi


if [ $res -eq 0 ]
then
str1=$(grep -ceivhn go*gle ../test_files/*.txt)
str2=$(./s21_grep -ceivhn go*gle ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "          after e: passed"
else 
echo "          after e: failed"
echo "GNU grep output:"
echo $str1
echo "s21_grep output:"
echo $str2
res=1
fi
fi

if [ $res -eq 0 ]
then
str1=$(grep -sfeivhn go*gle ../test_files/*.txt)
str2=$(./s21_grep -sfeivhn go*gle ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "         after sf: passed"
else 
echo "         after sf: failed"
echo "GNU grep output:"
echo $str1
echo "s21_grep output:"
echo $str2
res=1
fi
fi


if [ $res -eq 0 ]
then
str1=$(grep -cefivhn go*gle ../test_files/*.txt)
str2=$(./s21_grep -cefivhn go*gle ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "        after cef: passed"
else 
echo "        after cef: failed"
echo "GNU grep output:"
echo $str1
echo "s21_grep output:"
echo $str2
res=1
fi
fi


if [ $res -eq 0 ]
then
str1=$(grep -civhn go*gle ../test_files/*.txt)
str2=$(./s21_grep -civhn go*gle ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "            mix 2: passed"
else 
echo "            mix 2: failed"
echo "GNU grep output:"
echo $str1
echo "s21_grep output:"
echo $str2
res=1
fi
fi


if [ $res -eq 0 ]
then
str1=$(grep -ivhon go*gle ../test_files/*.txt)
str2=$(./s21_grep -ivhon go*gle ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "            ivhon: passed"
else 
echo "            ivhon: failed"
echo "GNU grep output:"
echo $str1
echo "s21_grep output:"
echo $str2
res=1
fi
fi


if [ $res -eq 0 ]
then
str1=$(grep -soli gle ../test_files/*.txt)
str2=$(./s21_grep -soli gle ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "             soli: passed"
else 
echo "             soli: failed"
echo "GNU grep output:"
echo $str1
echo "s21_grep output:"
echo $str2
res=1
fi
fi


if [ $res -eq 0 ]
then
str1=$(grep -one ^pu ../test_files/*.txt)
str2=$(./s21_grep -one ^pu ../test_files/*.txt)
if [ "$str1" == "$str2" ]
then
echo "          one ^pu: passed"
else 
echo "          one ^pu: failed"
echo "GNU grep output:"
echo $str1
echo "s21_grep output:"
echo $str2
res=1
fi
fi


# if [ $res -eq 0 ]
# then
# str1=$(grep -f pattern.txt ../test_files/txt1.txt)
# str2=$(./s21_grep -f pattern.txt ../test_files/txt1.txt)
# if [ "$str1" == "$str2" ]
# then
# echo "           -f pat: passed"
# else 
# echo "           -f pat: failed"
# echo "GNU grep output:"
# echo $str1
# echo "s21_grep output:"
# echo $str2
# res=1
# fi
# fi


echo
if [ $res -eq 0 ]
then
echo "         All tests passed"
else 
echo "            Error occured"
exit 1
fi

