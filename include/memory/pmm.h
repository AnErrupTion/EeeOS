//
// Created by anerruption on 06/03/23.
//

#ifndef EEEOS_PMM_H
#define EEEOS_PMM_H

#include <stdint.h>
#include <stddef.h>

#include "../multiboot.h"

void pmm_init(size_t max_memory_address, multiboot_memory_map_entry* memory_map, size_t memory_map_length);
size_t get_pages_in_use();
size_t get_page_size();
size_t get_total_usable_memory();
uint8_t* memory_alloc(size_t size);
void memory_free(uint8_t* buffer, size_t size);

#endif //EEEOS_PMM_H
