//
// Created by anerruption on 06/03/23.
//

#include "../include/pic.h"
#include "../include/port.h"

// Master PIC
#define PIC1_COMMAND 0x0020
#define PIC1_DATA 0x0021

// Slave
#define PIC2_COMMAND 0x00A0
#define PIC2_DATA 0x00A1

// EOI command
#define PIC_EOI 0x20

// Initialization commands
#define ICW1_ICW4	0x01		/* ICW4 (not) needed */
#define ICW1_SINGLE	0x02		/* Single (cascade) mode */
#define ICW1_INTERVAL4	0x04		/* Call address interval 4 (8) */
#define ICW1_LEVEL	0x08		/* Level triggered (edge) mode */
#define ICW1_INIT	0x10		/* Initialization - required! */

#define ICW4_8086	0x01		/* 8086/88 (MCS-80/85) mode */
#define ICW4_AUTO	0x02		/* Auto (normal) EOI */
#define ICW4_BUF_SLAVE	0x08		/* Buffered mode/slave */
#define ICW4_BUF_MASTER	0x0C		/* Buffered mode/master */
#define ICW4_SFNM	0x10		/* Special fully nested (not) */

void pic_remap(uint8_t offset1, uint8_t offset2)
{
    // Save masks
    uint8_t a1 = inb(PIC1_DATA);
    uint8_t a2 = inb(PIC2_DATA);

    // Start the initialization sequence (in cascade mode)
    outb(PIC1_COMMAND, ICW1_INIT + ICW1_ICW4);
    io_wait();
    outb(PIC2_COMMAND, ICW1_INIT + ICW1_ICW4);
    io_wait();

    // ICW2: Master PIC vector offset
    outb(PIC1_DATA, offset1);
    io_wait();

    // ICW2: Slave PIC vector offset
    outb(PIC2_DATA, offset2);
    io_wait();

    // ICW3: Tell Master PIC that there is a slave PIC at IRQ 2 (0000 0100)
    outb(PIC1_DATA, 4);
    io_wait();

    // ICW3: Tell Slave PIC its cascade identity (0000 0010)
    outb(PIC2_DATA, 2);
    io_wait();

    outb(PIC1_DATA, ICW4_8086);
    io_wait();
    outb(PIC2_DATA, ICW4_8086);
    io_wait();

    // Restore masks
    outb(PIC1_DATA, a1);
    outb(PIC2_DATA, a2);
}

void pic_init()
{
    pic_remap(0x20, 0x28);
}

void pic_disable()
{
    outb(PIC2_DATA, 0xFF);
    outb(PIC1_DATA, 0xFF);
}

void pic_send_eoi(uint8_t irq)
{
    if (irq >= 8) // One PIC can only handle 8 IRQs
    {
        outb(PIC2_COMMAND, PIC_EOI);
    }

    outb(PIC1_COMMAND, PIC_EOI);
}

void pic_set_irq_mask(uint8_t irq)
{
    uint16_t port;

    if (irq < 8)
    {
        port = PIC1_DATA;
    }
    else
    {
        port = PIC2_DATA;
        irq -= 8;
    }

    uint8_t value = inb(port) | (1 << irq);
    outb(port, value);
}

void pic_clear_irq_mask(uint8_t irq)
{
    uint16_t port;

    if (irq < 8)
    {
        port = PIC1_DATA;
    }
    else
    {
        port = PIC2_DATA;
        irq -= 8;
    }

    uint8_t value = inb(port) & ~(1 << irq);
    outb(port, value);
}