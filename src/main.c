//
// Created by anerruption on 05/03/23.
//

#include "../include/drivers/vga.h"
#include "../include/gdt.h"
#include "../include/pic.h"
#include "../include/idt.h"
#include "../include/drivers/ps2.h"
#include "../include/apps/shell.h"

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

    term_write_string("Launching shell...\n");
    shell_exec();

    for (;;)
    {
        asm("hlt");
    }
}