#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

void console() {
   char ch1[10000];
   char ch2[10000];
   FILE *file1, *file2;
   file1 = fopen("input1.txt", "w");
   file2 = fopen("input2.txt", "w");
   char c;
   int n1 = 0;
   int n2 = 0;
   while ((c = fgetc(stdin)) != EOF) {
       ch1[n1] = c;
       n1 += 1;
   }
   while ((c = fgetc(stdin)) != EOF) {
       ch2[n2] = c;
       n2 += 1;
   }
   fprintf(file1, "%s", ch1);
   fprintf(file2, "%s", ch2);
}
