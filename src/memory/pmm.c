//
// Created by anerruption on 06/03/23.
//

#include <stdbool.h>

#include "../../include/memory/pmm.h"
#include "../../include/std.h"
#include "../../include/drivers/vga.h"
#include "../../include/panic.h"

#define PAGE_SIZE 4096 // Size of one page
#define NUMBER_OF_MAPS 2 // Number of available Multiboot 2 memory map entries
#define TOTAL_PAGES 32639 // total_size / PAGE_SIZE -> round to the nearest number (not above)
#define BITMAP_UNIT_SIZE 8 // Size of one unit in the bitmap (BITMAP_UNIT_SIZE pages per unit)
#define BITMAP_SIZE 4080 // TOTAL_PAGES / BITMAP_UNIT_SIZE -> round to the nearest number above (?)
#define NUMBER_OF_PAGES 1 // BITMAP_SIZE / PAGE_SIZE (Number of pages to allocate to store BITMAP_SIZE pages) -> round to the nearest number above

typedef struct
{
    uint64_t address;
    uint64_t size;
} map;

uint8_t* bitmap;
map memory_maps[NUMBER_OF_MAPS];

void pmm_init(multiboot_memory_map_entry* memory_map, uint32_t memory_map_length)
{
    char int_str[15];
    size_t len;

    size_t total_size = 0;
    size_t index = 0;

    // Find all available memory map entries
    for (uint32_t i = 0; i < memory_map_length; i++)
    {
        multiboot_memory_map_entry entry = memory_map[i];

        if (entry.type == 1) // Available
        {
            term_write_string("Entry at address ");
            len = itoa(entry.address, int_str, 10);
            term_write(int_str, len);
            term_write_string(" of size ");
            len = itoa(entry.size, int_str, 10);
            term_write(int_str, len);
            term_write_char('\n');

            map current_map = {
                    .address = entry.address,
                    .size = entry.size
            };

            memory_maps[index++] = current_map;

            total_size += entry.size;
        }
    }

    term_write_string("Total available memory: ");
    len = itoa(total_size / 1024 / 1024, int_str, 10);
    term_write(int_str, len);
    term_write_string("M\n");

    // Allocate NUMBER_OF_PAGES pages for bitmap
    map best_map;
    bool found_map = false;

    for (size_t i = 0; i < NUMBER_OF_MAPS; i++)
    {
        map memory_map = memory_maps[i];

        if (BITMAP_SIZE <= memory_map.size)
        {
            best_map = memory_map;
            found_map = true;
            break;
        }
    }

    if (found_map == false)
    {
        abort("Unable to initialize PMM: Not enough memory.");
        return;
    }

    bitmap = (uint8_t*)best_map.address;

    // Reserve NUMBER_OF_PAGES pages for bitmap, in the bitmap itself
    for (size_t i = 0; i < NUMBER_OF_PAGES; i++)
    {
        bitmap[i] = 1;
    }

    // Set all other pages free
    for (size_t i = NUMBER_OF_PAGES; i < BITMAP_SIZE; i++)
    {
        bitmap[i] = 0;
    }
}

uint8_t* memory_alloc(size_t size)
{
    map best_map;
    bool found_map = false;

    for (size_t i = 0; i < NUMBER_OF_MAPS; i++)
    {
        map memory_map = memory_maps[i];

        if (size <= memory_map.size)
        {
            best_map = memory_map;
            found_map = true;
            break;
        }
    }

    if (found_map == false)
        return NULL;

    uint32_t address = best_map.address;

    size_t sz = size;
    while (sz % PAGE_SIZE != 0)
    {
        sz++;
    }

    size_t required_pages = sz / PAGE_SIZE;
    size_t satisfied_pages = 0;
    size_t index = 0;

    for (;;)
    {
        uint8_t pages = bitmap[index];

        for (size_t i = 0; i < BITMAP_UNIT_SIZE; i++)
        {
            if (satisfied_pages == required_pages)
            {
                return (uint8_t*)address;
            }

            if ((pages & (1 << i)) == 0)
            {
                satisfied_pages++;
                pages |= 1 << i;
                bitmap[index] = pages;
            }
            else
            {
                address += PAGE_SIZE;
                satisfied_pages = 0;
            }
        }

        index++;
    }
}

void memory_free(uint8_t* buffer)
{

}