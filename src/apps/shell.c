//
// Created by anerruption on 06/03/23.
//

#include "../../include/apps/shell.h"
#include "../../include/drivers/vga.h"
#include "../../include/drivers/ps2.h"
#include "../../include/drivers/acpi.h"
#include "../../include/utils/scan_map.h"
#include "../../include/memory/pmm.h"

size_t shell_read_line(char* buffer)
{
    size_t index = 0;

    for (;;)
    {
        asm("hlt");

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

        if (keyboard_char.type == BACKSPACE)
        {
            if (index > 0)
            {
                buffer[--index] = ' ';
                term_backspace();
            }
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
    char* buffer = (char*)memory_alloc(1024);
    char* int_str = (char*)memory_alloc(16);

    size_t len;

    for (;;)
    {
        term_write_string("> ");

        int size = shell_read_line(buffer);

        if (is_equal(buffer, "help", size))
        {
            term_write_string("help - Shows all commands.\nclear - Clears the screen.\nusedram - Shows the amount of used memory, in KiB.\ntotalram - Shows the total amount of usable memory, in MiB.\nshutdown - Shuts down the PC via ACPI.\nreset - Resets the PC via ACPI.\n");
        }
        else if (is_equal(buffer, "clear", size))
        {
            term_clear();
        }
        else if (is_equal(buffer, "usedram", size))
        {
            term_write_string("RAM in use: ");
            len = itoa(get_pages_in_use() * get_page_size() / 1024, int_str, 10);
            term_write(int_str, len);
            term_write_string("K\n");
        }
        else if (is_equal(buffer, "totalram", size))
        {
            term_write_string("Total usable memory: ");
            len = itoa(get_total_usable_memory() / 1024 / 1024, int_str, 10);
            term_write(int_str, len);
            term_write_string("M\n");
        }
        else if (is_equal(buffer, "shutdown", size))
        {
            term_write_string("Shutting down...\n");
            acpi_shutdown();
        }
        else if (is_equal(buffer, "reset", size))
        {
            term_write_string("Resetting...\n");
            acpi_reset();
        }
        else
        {
            term_write_string("Unknown command: ");
            for (size_t i = 0; i < size; i++)
            {
                term_write_char(buffer[i]);
            }
            term_write_char('\n');
        }
    }
}