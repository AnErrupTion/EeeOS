//
// Created by anerruption on 05/03/23.
//

#include "../include/vga.h"
#include "../include/gdt.h"
#include "../include/pic.h"
#include "../include/idt.h"
//#include "../include/ps2.h"

extern void test_irq();

void kernel_main()
{
    term_init();

    term_write_string("Initializing GDT...\n");
    gdt_init();

    term_write_string("Initializing PIC...\n");
    pic_init();

    term_write_string("Initializing IDT...\n");
    idt_init();

    /*term_write_string("Initializing PS/2...\n");
    ps2_init();*/

    test_irq();
}