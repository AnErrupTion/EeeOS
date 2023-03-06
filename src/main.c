//
// Created by anerruption on 05/03/23.
//

#include "../include/vga.h"
#include "../include/gdt.h"
#include "../include/pic.h"
#include "../include/idt.h"

void kernel_main()
{
    term_init();

    term_write_string("Initializing GDT...\n");
    gdt_init();

    term_write_string("Initializing PIC...\n");
    pic_init();

    term_write_string("Initializing IDT...\n");
    idt_init();

    term_write_string("Initializing PIT...\n");
    pic_clear_irq_mask(0);
}