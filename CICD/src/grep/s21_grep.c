#include "s21_grep.h"

pcre *re;
unsigned options = 0, opt_pcre = 0;
char pat_e_f[MAX_PAT] = {0};

int main(int argc, char *argv[]) {
    s21_grep(argc, argv);
    return 0;
}

void s21_grep(int argc, char **argv) {
    int ch = 0;
    while ((ch = getopt(argc, argv, "e:f:vihlcnsoe")) != -1) switch (ch) {
            case 'e':
            case 'f':
                options |= (ch == 'e') ? FLAG_E : FLAG_F;
                snprintf(pat_e_f, MAX_PAT, "%s", optarg);
                break;
            case 'v':
                options |= FLAG_V;
                break;
            case 'i':
                opt_pcre |= PCRE_CASELESS;
                break;
            case 'h':
                options |= FLAG_H;
                break;
            case 'l':
                options |= FLAG_L;
                break;
            case 'c':
                options |= FLAG_C;
                break;
            case 'n':
                options |= FLAG_N;
                break;
            case 's':
                options |= FLAG_S;
                break;
            case 'o':
                options |= FLAG_O;
                break;
            default:
                usage();
                exit(EXIT_FAILURE);
        }
    if (optind == argc) usage();
    if (options & FLAG_E || options & FLAG_F) {
        optind--;
        compile_pattern(argc, argv, pat_e_f);
    } else {
        compile_pattern(argc, argv, argv[optind]);
    }
}

void compile_pattern(int argc, char **argv, char *pat) {
    int erroffset = 0;
    const char *error;
    char *buf = NULL;
    FILE *fp;
    if (options & FLAG_F) {
        size_t size = 512;
        int len = 0;
        buf = (char *)malloc(size * sizeof(char));
        fp = get_text(argv[0], pat);
        char pattern[MAX_PAT] = {0};
        while ((len = getline(&buf, &size, fp)) != -1) {
            buf[strcspn(buf, "\n")] = 0;
            if (*pattern)
                snprintf(pattern, sizeof(pattern), "%s", "|"),
                    snprintf(pattern, sizeof(pattern), "%s", buf);
            else
                snprintf(pattern, sizeof(pattern), "%s", buf);
        }
        if (*pattern) pat = pattern;
        fclose(fp);
    }
    re = pcre_compile((char *)pat, opt_pcre, &error, &erroffset, NULL);
    if (!re) {
        fprintf(stderr, "s21_grep: pattern `%s': %s\n", pat, error);
    } else {
        optind++;
        if (optind == argc) {
            process(argc, "standard input", stdin);
        } else {
            for (int i = optind; i < argc; i++) {
                fp = get_text(argv[0], argv[i]);
                if (fp == NULL)
                    continue;
                else
                    process(argc, argv[i], fp), fclose(fp);
            }
        }
    }
    if (options & FLAG_F) free(buf);
    pcre_free(re);
}

void print_opts(int argc, const char *name, unsigned long line) {
    if (!(options & FLAG_H || argc <= 4)) {
        printf("%s:", name);
    }
    if (options & FLAG_N) {
        printf("%lu:", line);
    }
}

void process(int argc, const char *name, FILE *fp) {
    char *buf = NULL;
    int len = 0, match_txt = 0;
    unsigned long size = 8192, cnt_match = 0, line = 0;
    buf = (char *)malloc(size * sizeof(char));
    while ((len = getline(&buf, &size, fp)) != -1) {
        line++, buf[strcspn(buf, "\n")] = 0;
        int ovector[100] = {0};
        int rc = pcre_exec(re, NULL, (char *)buf, len, 0, 0, ovector, 100);
        if (rc == 1 && match_txt == 0) match_txt = 1;
        if (options & FLAG_L) {
            if (match_txt) {
                printf("%s\n", name);
                break;
            }
        } else if (options & FLAG_C) {
            if ((rc == 1 && (!(options & FLAG_V))) ||
                (rc == -1 && (options & FLAG_V)))
                cnt_match++;
        } else if (match_txt == 1 && (options & FLAG_O) &&
                   (!(options & FLAG_V))) {
            for (int i = 0; i < rc; i++) {
                char *substr_start = buf + ovector[2 * i];
                int sub_str_len = ovector[2 * i + 1] - ovector[2 * i];
                print_opts(argc, name, line);
                printf("%.*s\n", sub_str_len, substr_start);
                for (;;) {
                    int start = ovector[1];
                    if (ovector[0] == ovector[1]) {
                        if (ovector[0] == len) break;
                    }
                    rc = pcre_exec(re, NULL, (char *)buf, len, start, 0,
                                   ovector, 100);
                    if (rc == PCRE_ERROR_NOMATCH) {
                        break;
                    } else {
                        for (i = 0; i < rc; i++) {
                            substr_start = buf + ovector[2 * i];
                            sub_str_len = ovector[2 * i + 1] - ovector[2 * i];
                            print_opts(argc, name, line);
                            printf("%.*s\n", sub_str_len, substr_start);
                        }
                    }
                }
            }
        } else if ((!(options & FLAG_O)) &&
                   ((rc == -1 && options & FLAG_V) ||
                    (rc == 1 && !(options & FLAG_V)))) {
            if ((!((options & (FLAG_E | FLAG_F)) && strlen(buf) < 1)) ||
                (options & FLAG_V)) {
                print_opts(argc, name, line);
                printf("%s\n", buf);
            }
        }
    }
    if (options & FLAG_C) {
        if (!(options & FLAG_H || argc <= 4)) printf("%s:", name);
        printf("%lu\n", cnt_match);
    }
    free(buf);
}

void usage(void) {
    fprintf(stderr,
            "Usage: s21_grep [OPTION]... PATTERNS [FILE]...\nTry 'grep "
            "--help' for more information.\n");
    exit(1);
}

FILE *get_text(char *name, char *argv) {
    FILE *fp;
    if ((fp = fopen(argv, "r")) == NULL &&
        !((options & FLAG_S) && (!(options & FLAG_F)))) {
        fprintf(stderr, "%s: %s: %s\n", name, argv, strerror(errno));
    }
    return fp;
}
