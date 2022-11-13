#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

void writing() {
    srand(time(NULL));
    FILE *file1, *file2;
    int size1 = rand()%100;
    int size2 = rand()%100;
    char mass1[size1];
    char mass2[size2];
    for (int i = 0; i < size1; ++i) {
        mass1[i] = rand()%56+'A';
    }
    file1 = fopen("input1.txt", "w");
    fprintf(file1, "%s", mass1);
    fclose(file1);
    for (int i = 0; i < size2; ++i) {
        mass2[i] = rand()%56+'A';
    }
    file2 = fopen("input2.txt", "w");
    fprintf(file2, "%s", mass2);
    fclose(file2);
}
