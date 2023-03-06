//
// Created by anerruption on 06/03/23.
//

#ifndef EEEOS_PIC_H
#define EEEOS_PIC_H

#include <stdint.h>

void pic_remap(uint8_t offset1, uint8_t offset2);
void pic_init();
void pic_disable();
void pic_send_eoi(uint8_t irq);
void pic_set_irq_mask(uint8_t irq);
void pic_clear_irq_mask(uint8_t irq);

#endif //EEEOS_PIC_H
