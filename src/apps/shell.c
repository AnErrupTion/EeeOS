//
// Created by anerruption on 06/03/23.
//

#include "../../include/apps/shell.h"
#include "../../include/drivers/vga.h"
#include "../../include/drivers/ps2.h"
#include "../../include/utils/scan_map.h"
#include "../../include/memory/pmm.h"

int shell_read_line(char* buffer)
{
    int index = 0;

    for (;;)
    {
        uint8_t scan_code = ps2_get_scan_code();

        if (scan_code == 0)
        {
            continue;
        }

        key keyboard_char = get_keyboard_key(scan_code);

        if (keyboard_char.type == UNKNOWN)
        {
            continue;
        }

        if (keyboard_char.type == ENTER)
        {
            term_write_char('\n');
            return index;
        }

        buffer[index++] = keyboard_char.value;
        term_write_char(keyboard_char.value);
    }
}

void shell_exec()
{
    char* buffer = (char*) memory_alloc(128);

    char int_str[10];
    size_t len = itoa((uint32_t)buffer, int_str, 10);
    term_write(int_str, len);
    term_write_char('\n');

    for (;;)
    {
        term_write_string("> ");

        int size = shell_read_line(buffer);

        term_write_string("You typed: ");
        for (int i = 0; i < size; i++)
        {
            term_write_char(buffer[i]);
        }
        term_write_char('\n');
    }
}