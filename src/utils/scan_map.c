//
// Created by anerruption on 06/03/23.
//

#include "../../include/utils/scan_map.h"

key get_keyboard_key(uint8_t scan_code)
{
    key key;

    switch (scan_code)
    {
        case 14:
            key.type = BACKSPACE;
            break;
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
        case 30:
            key.type = NORMAL;
            key.value = 'a';
            break;
        case 31:
            key.type = NORMAL;
            key.value = 's';
            break;
        case 32:
            key.type = NORMAL;
            key.value = 'd';
            break;
        case 33:
            key.type = NORMAL;
            key.value = 'f';
            break;
        case 34:
            key.type = NORMAL;
            key.value = 'g';
            break;
        case 35:
            key.type = NORMAL;
            key.value = 'h';
            break;
        case 36:
            key.type = NORMAL;
            key.value = 'j';
            break;
        case 37:
            key.type = NORMAL;
            key.value = 'k';
            break;
        case 38:
            key.type = NORMAL;
            key.value = 'l';
            break;
        case 44:
            key.type = NORMAL;
            key.value = 'z';
            break;
        case 45:
            key.type = NORMAL;
            key.value = 'x';
            break;
        case 46:
            key.type = NORMAL;
            key.value = 'c';
            break;
        case 47:
            key.type = NORMAL;
            key.value = 'v';
            break;
        case 48:
            key.type = NORMAL;
            key.value = 'b';
            break;
        case 49:
            key.type = NORMAL;
            key.value = 'n';
            break;
        case 50:
            key.type = NORMAL;
            key.value = 'm';
            break;
        case 57:
            key.type = NORMAL;
            key.value = ' ';
            break;
        default:
            key.type = UNKNOWN;
            break;
    }

    return key;
}