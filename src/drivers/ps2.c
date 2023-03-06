//
// Created by anerruption on 06/03/23.
//

#include "../../include/drivers/ps2.h"
#include "../../include/pic.h"
#include "../../include/port.h"

#define DATA_PORT 0x60
#define STATUS_PORT 0x64
#define COMMAND_PORT 0x64

#define FIFO_SIZE 256

uint8_t fifo_buffer[FIFO_SIZE];
uint32_t fifo_start = 0;
uint32_t fifo_end = 0;

void ps2_on_interrupt()
{
    uint8_t status = inb(STATUS_PORT);

    if ((status & 0x01) == 0x01)
    {
        uint8_t data = inb(DATA_PORT);

        uint32_t next = fifo_end + 1;

        if (next == FIFO_SIZE)
        {
            next = 0; // Wrap around
        }

        if (next == fifo_start)
        {
            return; // We're out of room
        }

        fifo_buffer[next] = data;
        fifo_end = next;
    }
}

void ps2_init()
{
    // Enable keyboard handler in PIC (IRQ 1)
    pic_clear_irq_mask(1);
}

uint8_t ps2_get_scan_code()
{
    if (fifo_start == fifo_end)
    {
        return 0;
    }

    uint8_t value = fifo_buffer[fifo_start];

    fifo_start++;

    if (fifo_start == FIFO_SIZE)
    {
        fifo_start = 0; // Wrap around
    }

    return value;
}