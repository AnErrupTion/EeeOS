//
// Created by anerruption on 05/03/23.
//

#ifndef EEEOS_STD_H
#define EEEOS_STD_H

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

//https://github.com/limine-bootloader/limine/blob/886523359c85aa10691e6b82229c91f31f21a04f/common/lib/misc.h#L66
#define DIV_ROUNDUP(a, b) ({ \
    __auto_type DIV_ROUNDUP_a = (a); \
    __auto_type DIV_ROUNDUP_b = (b); \
    (DIV_ROUNDUP_a + (DIV_ROUNDUP_b - 1)) / DIV_ROUNDUP_b; \
})

size_t strlen(const char* str);
size_t itoa(uint64_t value, char* sp, int radix);
bool is_equal(char* buffer, const char* cmp, size_t size);

#endif //EEEOS_STD_H
