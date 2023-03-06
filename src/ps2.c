//
// Created by anerruption on 06/03/23.
//

#include "../include/ps2.h"
#include "../include/port.h"
#include "../include/pic.h"

#define DATA_PORT 0x60
#define STATUS_PORT 0x64
#define COMMAND_PORT 0x64

void ps2_init()
{
    // Enable keyboard handler in PIC (IRQ 1)
    outb(0x21, 0xFD);
    outb(0xA1, 0xFF);
    asm("sti");
}