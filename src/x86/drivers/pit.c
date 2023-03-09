//
// Created by anerruption on 09/03/23.
//

#include "../../../include/drivers/pit.h"
#include "../../../include/pic.h"

void pit_init()
{
    // Enable PIT in PIC (IRQ 0)
    pic_clear_irq_mask(0);
}

void pit_sleep(size_t ms)
{
    // TODO
}