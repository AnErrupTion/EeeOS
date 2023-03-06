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