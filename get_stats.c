#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <math.h>
 
char* getfield(char* line, int num)
{
    char* ptr = line;
    int count = 0;
    while (count < num) {
        if (*ptr == '\t')
            ++count;
        if (*ptr == '\0')
            return NULL;
        ++ptr;
    }

    char* ptr2 = ptr;
    while (1) {
        if (*ptr2 == '\t') {
            *ptr2 = '\0';
            return ptr;
        }
        ++ptr2;
    }
    return NULL;
}
 
int main()
{
    unsigned x[21] = {0};
    char line[1024];
    char* ep;
    char* sscore;
    while (fgets(line, 1024, stdin))
    {
        sscore = getfield(line, 30);
        if (sscore[0] != '\0') {
            x[(int)(floor(strtof(sscore, &ep))) + 10] += 1;
        }
    }
    for (int i = 0; i < 21; ++i) {
        printf("%d ", x[i]);
    }

    printf("\n");
}
