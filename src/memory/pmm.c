//
// Created by anerruption on 06/03/23.
//

#include <stdbool.h>

#include "../../include/memory/pmm.h"
#include "../../include/std.h"
#include "../../include/panic.h"

#define PAGE_SIZE 4096 // Size of one page
#define BITMAP_UNIT_SIZE 8 // Size of one unit in the bitmap (BITMAP_UNIT_SIZE pages per unit)

typedef uint8_t bitmap_unit;

typedef struct
{
    uint64_t address;
    uint64_t size;
} map;

typedef struct
{
    uint64_t from;
    uint64_t to;
} address_range;

bitmap_unit* bitmap;

size_t number_of_maps = 0; // Number of available Multiboot 2 memory map entries
size_t total_pages = 0; // Number of available pages
size_t bitmap_size = 0; // Size of the bitmap
size_t number_of_pages = 0; // Number of pages to allocate to store bitmap_size pages
size_t pages_in_use = 0; // Number of pages that are currently in use
size_t total_size = 0; // Total usable RAM, in bytes

void initialize_bitmap(uint32_t best_map_address, address_range* unavailable_address_ranges, size_t size)
{
    bitmap = (uint8_t*)best_map_address;

    // Initialize bitmap by setting all the pages free
    for (size_t i = 0; i < bitmap_size; i++)
    {
        bitmap[i] = 0;
    }

    // Mark unavailable pages as "allocated"
    size_t address = 0;
    size_t idx = 0;

    while (idx < bitmap_size)
    {
        bitmap_unit unit = bitmap[idx];

        for (size_t i = 0; i < BITMAP_UNIT_SIZE; i++)
        {
            for (size_t j = 0; j < size; j++)
            {
                address_range range = unavailable_address_ranges[j];
                // The address is in an unavailable range, mark it as "allocated"
                if (address > range.from && address < range.to)
                {
                    unit |= 1 << i;
                    bitmap[idx] = unit;
                }
            }

            address += PAGE_SIZE;
        }

        idx++;
    }

    // Reserve number_of_pages pages for bitmap, in the bitmap itself
    size_t satisfied_pages = 0;
    size_t index = 0;

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
    // Find all available memory map entries
    map memory_maps[memory_map_length];

    for (size_t i = 0; i < memory_map_length; i++)
    {
        multiboot_memory_map_entry entry = memory_map[i];

        // See https://en.wikipedia.org/wiki/PCI_hole
        if (entry.type == 1 && entry.address <= max_memory_address) // Available && writable
        {
            map current_map = {
                    .address = entry.address,
                    .size = entry.size
            };

            memory_maps[number_of_maps++] = current_map;

            total_size += entry.size;
        }
    }

    // Calculate the required values
    total_pages = total_size / PAGE_SIZE;
    bitmap_size = DIV_ROUNDUP(total_pages, BITMAP_UNIT_SIZE);
    number_of_pages = DIV_ROUNDUP(bitmap_size, PAGE_SIZE);

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

    if (!found_map)
    {
        abort("PMM: unable to initialize: not enough memory.");
        return;
    }

    // Find all unavailable address ranges
    address_range unavailable_address_ranges[memory_map_length];
    map last_memory_map;
    size_t range_size = 0;
    size_t index = 0;

    while (index < number_of_maps)
    {
        if (number_of_maps == 1)
        {
            break;
        }

        if (index == 0)
        {
            last_memory_map = memory_maps[index++];
        }

        map memory_map = memory_maps[index++];

        address_range range = {
                .from = last_memory_map.address + last_memory_map.size,
                .to = memory_map.address
        };

        unavailable_address_ranges[range_size++] = range;
        last_memory_map = memory_map;
    }

    // Initialize the bitmap with the memory map (and the unavailable address range) we found
    initialize_bitmap(best_map.address, unavailable_address_ranges, range_size);

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

size_t get_total_usable_memory()
{
    return total_size;
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

void memory_free(uint8_t* buffer, size_t size)
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

    uint32_t buffer_address = (uint32_t)buffer;

    for (;;)
    {
        bitmap_unit unit = bitmap[index];

        for (size_t i = 0; i < BITMAP_UNIT_SIZE; i++)
        {
            // We have freed the required number of pages, we can safely return now.
            if (satisfied_pages == required_pages)
            {
                pages_in_use -= satisfied_pages;
                return;
            }

            if (address == buffer_address)
            {
                satisfied_pages++;
                unit &= ~(1 << i);
                bitmap[index] = unit;
            }
            else
            {
                address += PAGE_SIZE;
            }
        }

        index++;
    }
}