//
// Created by anerruption on 06/03/23.
//

#ifndef EEEOS_MULTIBOOT_H
#define EEEOS_MULTIBOOT_H

typedef struct
{
    uint16_t attributes;
    uint8_t window_a, Window_b;
    uint16_t granularity;
    uint16_t window_size;
    uint16_t segment_a, Segment_b;
    uint16_t window_func[2];
    uint16_t pitch, width, height;
    uint8_t char_width, char_height, planes, depth, banks;
    uint8_t memory_model, bank_size, image_pages;
    uint8_t reserved0;
    uint8_t red_mask, red_position;
    uint8_t green_mask, green_position;
    uint8_t blue_mask, blue_position;
    uint8_t rsv_mask, rsv_position;
    uint8_t direct_color;
    uint32_t physical_base;
    uint32_t reserved1;
    uint16_t reserved2;
} __attribute__((packed)) multiboot_vbe_mode_info;

typedef struct
{
    char signature[4];
    uint16_t version;
    uint16_t oemstr[2];
    uint8_t capabilities[4];
    uint16_t videomode[2];
    uint16_t totalmem;
} __attribute__((packed)) multiboot_vbe_control_info;

typedef struct
{
    uint32_t address_start;
    uint32_t address_end;
    uint32_t string;
    uint32_t reserved;
} __attribute__((packed)) multiboot_module;

typedef struct
{
    uint32_t ent_size;
    uint64_t address;
    uint64_t size;
    uint32_t type;
} __attribute__((packed)) multiboot_memory_map_entry;

typedef struct
{
    uint32_t flags;
    uint32_t memory_lower;
    uint32_t memory_upper;
    uint32_t boot_device;
    char* command_line;
    uint32_t modules_count;
    multiboot_module* modules;
    uint32_t syms[4];
    uint32_t memory_map_length;
    multiboot_memory_map_entry* memory_map;
    uint32_t drives_count;
    uint32_t drives_addr;
    uint32_t config_table;
    char* bootloader_name;
    uint32_t table;
    multiboot_vbe_control_info* vbe_control_info;
    multiboot_vbe_mode_info* vbe_mode_info;
    uint32_t vbe_mode;
    uint32_t vbe_interface_seg;
    uint32_t vbe_interface_offset;
    uint32_t vbe_interface_length;
} __attribute__((packed)) multiboot_info;

#endif //EEEOS_MULTIBOOT_H
