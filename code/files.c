#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

void files() {
    FILE *file1, *file2;
    file1 = fopen("input1.txt", "r");
    file2 = fopen("input2.txt", "r");
    fclose(file1);
    fclose(file2);
}
