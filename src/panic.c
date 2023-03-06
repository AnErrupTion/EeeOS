//
// Created by anerruption on 06/03/23.
//

#include "../include/panic.h"
#include "../include/drivers/vga.h"

void abort(const char* msg)
{
    term_write_string(msg);
    for (;;) {}
}