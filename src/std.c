//
// Created by anerruption on 05/03/23.
//

#include "../include/std.h"

size_t strlen(const char* str)
{
    size_t len = 0;
    while (str[len])
        len++;
    return len;
}

//https://stackoverflow.com/a/12386915
size_t itoa(uint64_t value, char* sp, int radix)
{
    char tmp[16]; // be careful with the length of the buffer
    char *tp = tmp;

    uint64_t i;
    uint64_t v = value;

    while (v || tp == tmp)
    {
        i = v % radix;
        v /= radix;
        if (i < 10)
            *tp++ = i + '0';
        else
            *tp++ = i + 'a' - 10;
    }

    size_t len = tp - tmp;

    while (tp > tmp)
        *sp++ = *--tp;

    *sp = '\0';
    return len;
}