CFLAGS= -Wall -Wextra -Werror -Wshadow -std=c11

all: s21_grep test
	
s21_grep: clean
	gcc $(CFLAGS) s21_grep.c -lpcre -o s21_grep

test: clean s21_grep
	 ./grep-test.sh

check:
	-python3 ../../materials/linters/cpplint.py --extensions=c *.c
	-python3 ../../materials/linters/cpplint.py --extensions=h *.h

clean:
	rm -rf *.o *.gcda *.gcno *.info *.gch s21_grep test *.log

rebuild: clean all
