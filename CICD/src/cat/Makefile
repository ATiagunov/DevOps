CFLAGS= -Wall -Wextra -Werror -Wshadow -std=c11

all: s21_cat test
	
s21_cat: clean
	gcc $(CFLAGS) s21_cat.c -o s21_cat

test: clean s21_cat
	./cat-test.sh

check:
	-python3 ../../materials/linters/cpplint.py --extensions=c *.c
	-python3 ../../materials/linters/cpplint.py --extensions=h *.h

clean:
	rm -rf *.o *.gcda *.gcno *.info *.gch s21_cat

rebuild: clean all
