#pragma once

#include <ctype.h>
#include <err.h>
#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>

/*****************************************************************************
Options:
-b (GNU: --number-nonblank)	numbers only non-empty lines
-e implies -v (GNU only: -E the same, but without implying -v)	but also display
end-of-line characters as $ -n (GNU: --number)	number all output lines -s (GNU:
--squeeze-blank)	squeeze multiple adjacent blank lines -t implies -v (GNU: -T
the same, but without implying -v)	but also display tabs as ^I
*****************************************************************************/
void s21_cat(int argc, char *argv[]);

void process_cat(char **argv, int flags);
void make_stdout(FILE *, int first, int flags);
