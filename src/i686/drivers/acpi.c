//
// Created by anerruption on 09/03/23.
//

#include "../../../include/drivers/acpi.h"
#include "../../../include/drivers/vga.h"
#include "../../../include/panic.h"
#include "../../../include/port.h"

acpi_fadt* fadt;

void acpi_init()
{
    // Find RSDP
    rsdp_descriptor* rsdp;

    for (uint32_t addr = 0x000E0000; addr <= 0x000FFFFF; addr += 16)
    {
        if (is_equal((char*)addr, "RSD PTR ", 8))
        {
            rsdp = (rsdp_descriptor*)addr;
            break;
        }
    }

    if (rsdp == NULL)
    {
        abort("ACPI: could not find RSDP.");
        return;
    }

    if (rsdp->revision != 0)
    {
        term_write_string("ACPI: detected version 2.0+\n");

        rsdp_descriptor_20* rsdp_20 = (rsdp_descriptor_20*)rsdp;

        acpi_xsdt* xsdt = (acpi_xsdt*)rsdp_20->xsdt_address;

        size_t length = (xsdt->header.length - sizeof(xsdt->header)) / 8;

        for (size_t i = 0; i < length; i++)
        {
            acpi_std_header* header = (acpi_std_header*)xsdt->other_sdt_headers[i];

            if (is_equal(header->signature, "FACP", 4))
            {
                fadt = (acpi_fadt*)header;
                break;
            }
        }
    }
    else
    {
        acpi_rsdt* rsdt = (acpi_rsdt*)rsdp->rsdt_address;

        size_t length = (rsdt->header.length - sizeof(rsdt->header)) / 4;

        for (size_t i = 0; i < length; i++)
        {
            acpi_std_header* header = (acpi_std_header*)rsdt->other_sdt_headers[i];

            if (is_equal(header->signature, "FACP", 4))
            {
                fadt = (acpi_fadt*)header;
                break;
            }
        }
    }

    if (fadt == NULL)
    {
        abort("ACPI: could not find FADT.");
        return;
    }
}

void acpi_enable()
{
    outb(fadt->smi_command_port, fadt->acpi_enable);
    while ((inw(fadt->pm1a_control_block) & 1) == 0); // Wait for ACPI to be enabled
}

void acpi_disable()
{
    outb(fadt->smi_command_port, fadt->acpi_disable);
    while ((inw(fadt->pm1a_control_block) & 1) != 0); // Wait for ACPI to be disabled
}

void acpi_shutdown()
{
    // TODO
}

void acpi_reset()
{
    if (fadt->header.revision < 2)
    {
        term_write_string("ACPI: reset is not supported by this PC: FADT is too old.\n");
        return;
    }

    if ((fadt->flags & (1 << 10)) == 0)
    {
        term_write_string("ACPI: reset is not supported by this PC: feature not supported.\n");
        return;
    }

    outb(fadt->reset_reg.address, fadt->reset_value);
}