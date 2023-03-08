//
// Created by anerruption on 06/03/23.
//

#include <stdbool.h>

#include "../../include/memory/pmm.h"
#include "../../include/std.h"
#include "../../include/drivers/vga.h"
#include "../../include/panic.h"

#define PAGE_SIZE 4096 // Size of one page
#define BITMAP_UNIT_SIZE 8 // Size of one unit in the bitmap (BITMAP_UNIT_SIZE pages per unit)

typedef uint8_t bitmap_unit;

typedef struct
{
    uint64_t address;
    uint64_t size;
} map;

bitmap_unit* bitmap;

size_t number_of_maps = 0; // Number of available Multiboot 2 memory map entries
size_t total_pages = 0; // Number of available pages
size_t bitmap_size = 0; // Size of the bitmap
size_t number_of_pages = 0; // Number of pages to allocate to store bitmap_size pages
size_t pages_in_use = 0; // Number of pages that are currently in use

// TODO: Mark pages not available (like 640k-0x100000) as "allocated"
void initialize_bitmap(map best_map)
{
    bitmap = (uint8_t*)best_map.address;

    size_t satisfied_pages = 0;
    size_t index = 0;

    // Initialize bitmap by setting all the pages free
    for (size_t i = 0; i < bitmap_size; i++)
    {
        bitmap[i] = 0;
    }

    // Reserve number_of_pages pages for bitmap, in the bitmap itself
    for (;;)
    {
        bitmap_unit unit = bitmap[index];

        for (size_t i = 0; i < BITMAP_UNIT_SIZE; i++)
        {
            // We have allocated the required number of pages, we can safely return the buffer now.
            if (satisfied_pages == number_of_pages)
            {
                return;
            }

            // We found a free page!
            if ((unit & (1 << i)) == 0)
            {
                satisfied_pages++;
                unit |= 1 << i;
                bitmap[index] = unit;
            }
            // This should never happen
            else
            {
                abort("PMM: found an allocated page when trying to allocate the bitmap.");
                return;
            }
        }

        index++;
    }
}

void pmm_init(size_t max_memory_address, multiboot_memory_map_entry* memory_map, size_t memory_map_length)
{
    char int_str[15];
    size_t len;

    size_t total_size = 0;

    map memory_maps[memory_map_length];

    // Find all available memory map entries
    for (size_t i = 0; i < memory_map_length; i++)
    {
        multiboot_memory_map_entry entry = memory_map[i];

        // See https://en.wikipedia.org/wiki/PCI_hole
        if (entry.type == 1 && entry.address <= max_memory_address) // Available && writable
        {
            term_write_string("Entry at address 0x");
            len = itoa(entry.address, int_str, 16);
            term_write(int_str, len);
            term_write_string(" of size 0x");
            len = itoa(entry.size, int_str, 16);
            term_write(int_str, len);
            term_write_char('\n');

            map current_map = {
                    .address = entry.address,
                    .size = entry.size
            };

            memory_maps[number_of_maps++] = current_map;

            total_size += entry.size;
        }
    }

    term_write_string("Total usable memory: ");
    len = itoa(total_size / 1024 / 1024, int_str, 10);
    term_write(int_str, len);
    term_write_string("M\n");

    // Calculate the required values
    total_pages = total_size / PAGE_SIZE;
    bitmap_size = DIV_ROUNDUP(total_pages, BITMAP_UNIT_SIZE);
    number_of_pages = DIV_ROUNDUP(bitmap_size, PAGE_SIZE);

    term_write_string("Total pages: ");
    len = itoa(total_pages, int_str, 10);
    term_write(int_str, len);
    term_write_char('\n');

    term_write_string("Bitmap size: ");
    len = itoa(bitmap_size, int_str, 10);
    term_write(int_str, len);
    term_write_char('\n');

    term_write_string("Number of pages: ");
    len = itoa(number_of_pages, int_str, 10);
    term_write(int_str, len);
    term_write_char('\n');

    // Find a memory map for bitmap
    map best_map;
    bool found_map = false;

    for (size_t i = 0; i < number_of_maps; i++)
    {
        map memory_map = memory_maps[i];

        if (bitmap_size <= memory_map.size)
        {
            best_map = memory_map;
            found_map = true;
            break;
        }
    }

    if (found_map == false)
    {
        abort("PMM: unable to initialize: not enough memory.");
        return;
    }

    // Initialize the bitmap with the memory map we found
    initialize_bitmap(best_map);

    // At this point, we are using number_of_pages pages
    pages_in_use = number_of_pages;
}

size_t get_pages_in_use()
{
    return pages_in_use;
}

size_t get_page_size()
{
    return PAGE_SIZE;
}

uint8_t* memory_alloc(size_t size)
{
    // Calculate the required values
    size_t sz = size;
    while (sz % PAGE_SIZE != 0)
    {
        sz++;
    }

    size_t required_pages = sz / PAGE_SIZE;
    size_t satisfied_pages = 0;
    size_t index = 0;
    size_t address = 0;

    for (;;)
    {
        bitmap_unit unit = bitmap[index];

        for (size_t i = 0; i < BITMAP_UNIT_SIZE; i++)
        {
            // We have allocated the required number of pages, we can safely return the buffer now.
            if (satisfied_pages == required_pages)
            {
                pages_in_use += satisfied_pages;
                return (uint8_t*)address;
            }

            // We found a free page!
            if ((unit & (1 << i)) == 0)
            {
                satisfied_pages++;
                unit |= 1 << i;
                bitmap[index] = unit;
            }
            // Either we still didn't find a free page, or the next page is allocated.
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