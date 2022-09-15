Команды проверок:
cppcheck --enable=all --suppress=missingIncludeSystem *.c
valgrind --leak-check=full -v ./s21_grep
python3 ../materials/linters/cpplint.py --extensions=c grep/*.c


##Установка PCRE на Linux:
apt-get update
apt-get install libpcre3 libpcre3-dev

##На Mac:
brew install pcre