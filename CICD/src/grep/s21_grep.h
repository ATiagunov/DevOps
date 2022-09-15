#pragma once

#define _GNU_SOURCE
#include <errno.h>
#include <pcre.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

#define MAX_PAT 8192
#define FLAG_E (1U << 0)
#define FLAG_F (1U << 1)
#define FLAG_V (1U << 2)
#define FLAG_H (1U << 3)
#define FLAG_L (1U << 4)
#define FLAG_C (1U << 5)
#define FLAG_N (1U << 6)
#define FLAG_S (1U << 7)
#define FLAG_O (1U << 8)

/********************************************************************
 * 
Options:
-e	regex pattern in file
-f	same as e but from a file
-v	all strings that are not pattern
-i	ignore uppercase vs. lowercase
-h	output matching lines without preceding them by file names
-l	output matching files only, return if at least 1 match
-c	output count of matching lines
-n	precede each matching line with a line number
-s	suppress error messages about nonexistent or unreadable files
-o	output the matched char of a matching line + \n
*
********************************************************************/
void s21_grep(int argc, char *argv[]);
int choose_f_or_e(char **argv);
void get_pattern(int argc, char **argv, int ch);
void compile_pattern(int argc, char **argv, char *pat);
void process(int argc, const char *name, FILE *fp);
void set_opts(int argc, char **argv);

void usage(void);

FILE *get_text(char *name, char *argv);
