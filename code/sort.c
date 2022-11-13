#include <stdio.h>
#include <string.h>
#include <unistd.h>

void sort(char* str) {
    char tmp;
    for (int i = 0; i < strlen(str); ++i) {
        for (int j = 0; j < strlen(str); ++j) {
            if (str[j] > str [i]) {
                tmp = str[j];
                str[j] = str[i];
                str[i] = tmp;
            }
        }
    }
}