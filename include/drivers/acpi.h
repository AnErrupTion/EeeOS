//
// Created by anerruption on 09/03/23.
//

#ifndef EEEOS_ACPI_H
#define EEEOS_ACPI_H

#include <stdint.h>

typedef struct
{
    char signature[8];
    uint8_t checksum;
    char oem_id[6];
    uint8_t revision;
    uint32_t rsdt_address;
} __attribute__((packed)) rsdp_descriptor;

typedef struct
{
    rsdp_descriptor base;

    uint32_t length;
    uint64_t xsdt_address;
    uint8_t extended_checksum;
    uint8_t reserved[3];
} __attribute__((packed)) rsdp_descriptor_20;

typedef struct
{
    char signature[4];
    uint32_t length;
    uint8_t revision;
    uint8_t checksum;
    char oem_id[6];
    char oem_table_id[8];
    uint32_t oem_revision;
    uint32_t creator_id;
    uint32_t creator_revision;
} __attribute__((packed)) acpi_std_header;

typedef struct
{
    acpi_std_header header;

    uint32_t other_sdt_headers[64];
} __attribute__((packed)) acpi_rsdt;

typedef struct
{
    acpi_std_header header;

    uint64_t other_sdt_headers[64];
} __attribute__((packed)) acpi_xsdt;

typedef struct
{
    uint8_t address_space;
    uint8_t bit_width;
    uint8_t bit_offset;
    uint8_t access_size;
    uint64_t address;
} __attribute__((packed)) generic_addr_struct;

typedef struct
{
    acpi_std_header header;

    uint32_t firmware_ctrl;
    uint32_t dsdt;

    // Field used in ACPI 1.0 only, no longer in use
    uint8_t reserved;

    uint8_t preferred_power_management_profile;
    uint16_t sci_interrupt;
    uint32_t smi_command_port;
    uint8_t acpi_enable;
    uint8_t acpi_disable;
    uint8_t s4bios_req;
    uint8_t pstate_control;
    uint32_t pm1a_event_block;
    uint32_t pm1b_event_block;
    uint32_t pm1a_control_block;
    uint32_t pm1b_control_block;
    uint32_t pm2_control_block;
    uint32_t pm_timer_block;
    uint32_t gpe0_block;
    uint32_t gpe1_block;
    uint8_t pm1_event_length;
    uint8_t pm1_control_length;
    uint8_t pm2_control_length;
    uint8_t pm_timer_length;
    uint8_t gpe0_length;
    uint8_t gpe1_length;
    uint8_t gpe1_base;
    uint8_t cstate_control;
    uint16_t worst_c2_latency;
    uint16_t worst_c3_latency;
    uint16_t flush_size;
    uint16_t flush_stride;
    uint8_t duty_offset;
    uint8_t duty_width;
    uint8_t day_alarm;
    uint8_t month_alarm;
    uint8_t century;

    // Reserved in ACPI 1.0, used in ACPI 2.0+
    uint16_t boot_architecture_flags;

    uint8_t reserved2;

    uint32_t flags;

    // Works only in ACPI 2.0+ (in theory)
    generic_addr_struct reset_reg;
    uint8_t reset_value;

    uint8_t reserved3[3];

    // 64-bit pointers available on ACPI 2.0+

    uint64_t x_firmware_control;
    uint64_t x_dsdt;

    generic_addr_struct x_pm1a_event_block;
    generic_addr_struct x_pm1b_event_block;
    generic_addr_struct x_pm1a_control_block;
    generic_addr_struct x_pm1b_control_block;
    generic_addr_struct x_pm2_control_block;
    generic_addr_struct x_pm_timer_block;
    generic_addr_struct x_gpe0_block;
    generic_addr_struct x_gpe1_block;
} __attribute__((packed)) acpi_fadt;

void acpi_init();
void acpi_enable();
void acpi_disable();
void acpi_shutdown();
void acpi_reset();

#endif //EEEOS_ACPI_H
