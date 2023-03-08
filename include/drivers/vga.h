//
// Created by anerruption on 05/03/23.
//

#ifndef EEEOS_VGA_H
#define EEEOS_VGA_H

#include <stddef.h>
#include <stdint.h>

#include "../std.h"

void term_clear();
void term_init();
void term_set_color(uint8_t color);
void term_write_char(char c);
void term_write(const char* data, size_t size);
void term_write_string(const char* data);
void term_backspace();

#endif //EEEOS_VGA_H
