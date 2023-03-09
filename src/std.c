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
size_t itoa(uint64_t value, char* buffer, int radix)
{
    uint64_t i;
    uint64_t v = value;

    size_t len = 0;

    while (v)
    {
        i = v % radix;
        v /= radix;

        if (i < 10)
        {
            buffer[len] = i + '0';
        }
        else
        {
            buffer[len] = i + 'a' - 10;
        }

        len++;
    }

    size_t index = 0;
    size_t length = len - 1;

    while (index < length)
    {
        char value = buffer[index];
        buffer[index] = buffer[length];
        buffer[length] = value;

        index++;
        length--;
    }

    buffer[len] = '\0';

    return len;
}

bool is_equal(char* buffer, const char* cmp, size_t size)
{
    size_t cmp_size = strlen(cmp);

    if (cmp_size != size)
    {
        return false;
    }

    for (size_t i = 0; i < size; i++)
    {
        if (buffer[i] != cmp[i])
        {
            return false;
        }
    }

    return true;
}