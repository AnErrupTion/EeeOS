//
// Created by anerruption on 05/03/23.
//

#include "../include/drivers/vga.h"
#include "../include/multiboot.h"
#include "../include/gdt.h"
#include "../include/pic.h"
#include "../include/idt.h"
#include "../include/drivers/ps2.h"
#include "../include/apps/shell.h"
#include "../include/memory/pmm.h"

void test_alloc()
{
    char* int_str = (char*)memory_alloc(10);

    size_t len = itoa((uint32_t)int_str, int_str, 10);
    term_write(int_str, len);
    term_write_char('\n');

    int_str = (char*)memory_alloc(8192);
    len = itoa((uint32_t)int_str, int_str, 10);
    term_write(int_str, len);
    term_write_char('\n');

    int_str = (char*)memory_alloc(10);
    len = itoa((uint32_t)int_str, int_str, 10);
    term_write(int_str, len);
    term_write_char('\n');
}

void kernel_main(multiboot_info* info)
{
    term_init();

    term_write_string("Boot loader: ");
    term_write_string(info->bootloader_name);
    term_write_char('\n');
    term_write_string("Command line: ");
    term_write_string(info->command_line);
    term_write_char('\n');

    term_write_string("Initializing PMM...\n");
    pmm_init(info->memory_map, info->memory_map_length);

    test_alloc();

    term_write_string("Initializing GDT...\n");
    gdt_init();

    term_write_string("Initializing PIC...\n");
    pic_init();

    term_write_string("Initializing IDT...\n");
    idt_init();

    term_write_string("Initializing PS/2...\n");
    ps2_init();

    term_write_string("Launching shell...\n");
    shell_exec();

    for (;;)
    {
        asm("hlt");
    }
}