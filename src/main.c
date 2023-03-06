//
// Created by anerruption on 05/03/23.
//

#include "../include/drivers/vga.h"
#include "../include/gdt.h"
#include "../include/pic.h"
#include "../include/idt.h"
#include "../include/drivers/ps2.h"
#include "../include/drivers/scan_map.h"

int read_line(char* buffer)
{
    int index = 0;

    for (;;)
    {
        uint8_t scan_code = ps2_get_scan_code();

        if (scan_code == 0)
        {
            continue;
        }

        key keyboard_char = get_keyboard_char(scan_code);

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

void kernel_main()
{
    term_init();

    term_write_string("Initializing GDT...\n");
    gdt_init();

    term_write_string("Initializing PIC...\n");
    pic_init();

    term_write_string("Initializing IDT...\n");
    idt_init();

    term_write_string("Initializing PS/2...\n");
    ps2_init();

    char buffer[128];

    for (;;)
    {
        term_write_string("> ");

        int size = read_line(buffer);

        term_write_string("You typed: ");
        for (int i = 0; i < size; i++)
        {
            term_write_char(buffer[i]);
        }
        term_write_char('\n');

        //asm volatile("hlt");
    }
}