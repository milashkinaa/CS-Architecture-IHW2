#include <stdio.h>
#include <string.h>
#include <unistd.h>

int equals(char* a, char elem) {
    if (a == NULL) {
        return 5;
    } else {
        for (int i = 0; i < strlen(a); i++) {
            if (a[i] == elem) {
                return 1;
            }
        }
        return 5;
    }
}