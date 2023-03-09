//
// Created by anerruption on 05/03/23.
//

#include <stdint.h>

#include "../../../include/gdt.h"
#include "../../../include/memory/pmm.h"

#define GDT_ENTRIES 3

extern void load_gdt(uint32_t gdtr);

typedef struct
{
    uint16_t size;
    uint32_t offset;
} __attribute__((packed)) gdtr;

typedef struct
{
    uint16_t limit_low;  // Lower 16 bits of segment limit
    uint16_t base_low;   // Lower 16 bits of segment base address
    uint8_t base_middle; // Middle 8 bits of segment base address
    uint8_t access;      // Segment access permissions
    uint8_t granularity; // Segment size and granularity
    uint8_t base_high;   // Upper 8 bits of segment base address
} __attribute__((packed)) gdt_entry;

gdt_entry* gdt_entries;

void gdt_add_segment(uint32_t index, uint32_t address, uint32_t limit, uint8_t access, uint8_t granularity)
{
    gdt_entry entry = {
            .base_low = (uint16_t)(address & 0xFFFF),
            .base_middle = (uint8_t)((address >> 16) & 0xFF),
            .base_high = (uint8_t)((address >> 24) & 0xFF),
            .limit_low = (uint16_t)(limit & 0xFFFF),
            .granularity = (uint8_t)(((uint8_t)(limit >> 16) & 0x0F) | (granularity & 0xF0)),
            .access = access
    };

    gdt_entries[index] = entry;
}

void gdt_init()
{
    // Initialize buffer
    gdt_entries = (gdt_entry*)memory_alloc(GDT_ENTRIES * sizeof(gdt_entry));

    // Add all segments into GDT
    gdt_add_segment(0, 0, 0, 0, 0); // Null segment
    gdt_add_segment(1, 0, 0xFFFFFFFF, 0x9A, 0xCF); // Code segment
    gdt_add_segment(2, 0, 0xFFFFFFFF, 0x92, 0xCF); // Data segment

    // Load GDT
    gdtr gdt = {
            .size = (sizeof(gdt_entry) * GDT_ENTRIES) - 1,
            .offset = (uint32_t)gdt_entries
    };

    load_gdt((uint32_t)&gdt);
}