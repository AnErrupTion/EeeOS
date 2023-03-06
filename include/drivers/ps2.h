//
// Created by anerruption on 06/03/23.
//

#ifndef EEEOS_PS2_H
#define EEEOS_PS2_H

#include <stdint.h>

void ps2_init();
void ps2_on_interrupt();
uint8_t ps2_get_scan_code();

#endif //EEEOS_PS2_H
