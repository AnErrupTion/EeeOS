//
// Created by anerruption on 06/03/23.
//

#ifndef EEEOS_SCAN_MAP_H
#define EEEOS_SCAN_MAP_H

#include <stdint.h>

typedef enum
{
    UNKNOWN,
    NORMAL,
    ENTER,
    BACKSPACE
} key_type;

typedef struct
{
    key_type type;
    char value;
} key;

key get_keyboard_key(uint8_t scan_code);

#endif //EEEOS_SCAN_MAP_H
