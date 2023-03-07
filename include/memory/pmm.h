//
// Created by anerruption on 06/03/23.
//

#ifndef EEEOS_PMM_H
#define EEEOS_PMM_H

#include <stdint.h>
#include <stddef.h>

#include "../multiboot.h"

typedef uint32_t address_type;

void pmm_init(address_type max_memory_address, multiboot_memory_map_entry* memory_map, size_t memory_map_length);
uint8_t* memory_alloc(size_t size);
void memory_free(uint8_t* buffer);

#endif //EEEOS_PMM_H
