#include <stdio.h>

extern long long unsigned my_cpuid(int param);

int main(void) {

    long long unsigned t;
    t = my_cpuid(0);
    int x = 0;
    t = my_cpuid(0) - t;
    printf("%llu\n", t);
    return x;
}