//
// Created by anerruption on 06/03/23.
//

#include "../../include/drivers/scan_map.h"

key get_keyboard_char(uint8_t scan_code)
{
    key key;

    switch (scan_code)
    {
        case 16:
            key.type = NORMAL;
            key.value = 'q';
            break;
        case 17:
            key.type = NORMAL;
            key.value = 'w';
            break;
        case 18:
            key.type = NORMAL;
            key.value = 'e';
            break;
        case 19:
            key.type = NORMAL;
            key.value = 'r';
            break;
        case 20:
            key.type = NORMAL;
            key.value = 't';
            break;
        case 21:
            key.type = NORMAL;
            key.value = 'y';
            break;
        case 22:
            key.type = NORMAL;
            key.value = 'u';
            break;
        case 23:
            key.type = NORMAL;
            key.value = 'i';
            break;
        case 24:
            key.type = NORMAL;
            key.value = 'o';
            break;
        case 25:
            key.type = NORMAL;
            key.value = 'p';
            break;
        case 28:
            key.type = ENTER;
            break;
        default:
            key.type = UNKNOWN;
            break;
    }

    return key;
}