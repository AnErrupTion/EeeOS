//
// Created by anerruption on 06/03/23.
//

#ifndef EEEOS_PORT_H
#define EEEOS_PORT_H

#include <stdint.h>

void outb(uint16_t port, uint8_t value);
void outw(uint16_t port, uint16_t value);

uint8_t inb(uint16_t port);
uint16_t inw(uint16_t port);

void io_wait();

#endif //EEEOS_PORT_H
