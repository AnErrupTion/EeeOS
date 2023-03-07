//
// Created by anerruption on 05/03/23.
//

#ifndef EEEOS_STD_H
#define EEEOS_STD_H

#include <stddef.h>
#include <stdint.h>

size_t strlen(const char* str);
size_t itoa(uint64_t value, char* sp, int radix);
int round(float value);

#endif //EEEOS_STD_H
