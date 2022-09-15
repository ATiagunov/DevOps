#include "s21_cat.h"

#define FLAG_B (1 << 0)
#define FLAG_E (1 << 1)
#define FLAG_N (1 << 2)
#define FLAG_S (1 << 3)
#define FLAG_T (1 << 4)
#define FLAG_V (1 << 5)

static int line;
static const char *filename;

static struct option const long_options[] = {
    {"number-nonblank", no_argument, NULL, 'b'},
    {"number", no_argument, NULL, 'n'},
    {"squeeze-blank", no_argument, NULL, 's'},
    {NULL, 0, NULL, 0}};

void s21_cat(int argc, char *argv[]) {
    int ch, flags = 0;
    while ((ch = getopt_long(argc, argv, "bneEstTv", long_options, NULL)) != -1)
        switch (ch) {
            case 'b':
            case 'n':
                flags |= (ch == 'b') ? FLAG_B | FLAG_N : FLAG_N;
                break;
            case 'e':
            case 'E':
                flags |= (ch == 'e') ? FLAG_E | FLAG_V : FLAG_E;
                break;
            case 's':
                flags |= FLAG_S;
                break;
            case 't':
            case 'T':
                flags |= (ch == 't') ? FLAG_T | FLAG_V : FLAG_T;
                break;
            case 'v':
                flags |= FLAG_V;
                break;
            default:
                (void)fprintf(stderr,
                              "Try 'cat --help' for more information.\n");
                exit(EXIT_FAILURE);
        }
    argv += optind;
    process_cat(argv, flags);
    if (fclose(stdout)) err(EXIT_FAILURE, "stderr");
}

void process_cat(char **argv, int flags) {
    int first = 1;
    while (*argv) {
        FILE *file;
        if ((file = fopen(*argv, "r")) == NULL) {
            warn("%s", *argv);
            ++argv;
            continue;
        }
        filename = *argv++;
        make_stdout(file, first, flags);
        first = 0;
        if (file != stdin)
            (void)fclose(file);
        else
            clearerr(file);
    }
}

void make_stdout(FILE *fp, int first, int flags) {
    int ch = 0, prev = 0, suppress = 0;
    for (prev = (first) ? '\n' : 0; (ch = getc(fp)) != EOF; prev = ch) {
        if (prev == '\n') {
            if (flags & FLAG_S) {
                if (ch == '\n') {
                    if (suppress) continue;
                    suppress = 1;
                } else {
                    suppress = 0;
                }
            }
            if (flags & FLAG_N) {
                if (!(flags & FLAG_B) || ch != '\n') {
                    (void)fprintf(stdout, "%6d\t", ++line);
                    if (ferror(stdout)) break;
                }
            }
        }
        if (ch == '\n') {
            if (flags & FLAG_E)
                if (putchar('$') == EOF) break;
        } else if (ch == '\t') {
            if (flags & FLAG_T) {
                if (putchar('^') == EOF || putchar('I') == EOF) break;
                continue;
            }
        } else if (flags & FLAG_V) {
            if (ch > 127 || ch < 0) {
                if (putchar('M') == EOF || putchar('-') == EOF) break;
                ch = ch - 128;
            }
            if (iscntrl(ch)) {
                if (putchar('^') == EOF ||
                    putchar(ch == '\177' ? '?' : ch | 0100) == EOF)
                    break;
                continue;
            }
        }
        putchar(ch);
    }
    if (ferror(fp)) {
        warn("%s", filename);
        clearerr(fp);
    }
    if (ferror(stdout)) err(EXIT_FAILURE, "stderr");
}

int main(int argc, char *argv[]) {
    s21_cat(argc, argv);
    return 0;
}
