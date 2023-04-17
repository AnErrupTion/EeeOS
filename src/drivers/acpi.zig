const std = @import("std");
const arch = @import("../arch.zig");
const terminal = @import("../terminal.zig");

const rsdp = extern struct {
    signature: [8]u8 align(1),
    checksum: u8 align(1),
    oem_id: [6]u8 align(1),
    revision: u8 align(1),
    rsdt_address: u32 align(1),
};

const rsdp_20 = extern struct {
    base: rsdp align(1),

    length: u32 align(1),
    xsdt_address: u64 align(1),
    extended_checksum: u8 align(1),
    reserved: [3]u8 align(1),
};

const std_header = extern struct {
    signature: [4]u8 align(1),
    length: u32 align(1),
    revision: u8 align(1),
    checksum: u8 align(1),
    oem_id: [6]u8 align(1),
    oem_table_id: [8]u8 align(1),
    oem_revision: u32 align(1),
    creator_id: u32 align(1),
    creator_revision: u32 align(1),
};

const rsdt = extern struct {
    header: std_header align(1),

    other_sdt_headers: [64]u32 align(1),
};

const xsdt = extern struct {
    header: std_header align(1),

    other_sdt_headers: [64]u64 align(1),
};

const generic_addr_struct = extern struct {
    address_space: u8 align(1),
    bit_width: u8 align(1),
    bit_offset: u8 align(1),
    access_size: u8 align(1),
    address: u64 align(1),
};

const fadt = extern struct {
    header: std_header align(1),

    firmware_ctrl: u32 align(1),
    dsdt: u32 align(1),

    // Field used in ACPI 1.0 only, no longer in use
    reserved: u8 align(1),

    preferred_power_management_profile: u8 align(1),
    sci_interrupt: u16 align(1),
    smi_command_port: u32 align(1),
    acpi_enable: u8 align(1),
    acpi_disable: u8 align(1),
    s4bios_req: u8 align(1),
    pstate_control: u8 align(1),
    pm1a_event_block: u32 align(1),
    pm1b_event_block: u32 align(1),
    pm1a_control_block: u32 align(1),
    pm1b_control_block: u32 align(1),
    pm2_control_block: u32 align(1),
    pm_timer_block: u32 align(1),
    gpe0_block: u32 align(1),
    gpe1_block: u32 align(1),
    pm1_event_length: u8 align(1),
    pm1_control_length: u8 align(1),
    pm2_control_length: u8 align(1),
    pm_timer_length: u8 align(1),
    gpe0_length: u8 align(1),
    gpe1_length: u8 align(1),
    gpe1_base: u8 align(1),
    cstate_control: u8 align(1),
    worst_c2_latency: u16 align(1),
    worst_c3_latency: u16 align(1),
    flush_size: u16 align(1),
    flush_stride: u16 align(1),
    duty_offset: u8 align(1),
    duty_width: u8 align(1),
    day_alarm: u8 align(1),
    month_alarm: u8 align(1),
    century: u8 align(1),

    // Reserved in ACPI 1.0, used in ACPI 2.0+
    boot_architecture_flags: u16 align(1),

    reserved2: u8 align(1),

    flags: u32 align(1),

    // Works only in ACPI 2.0+ (in theory)
    reset_reg: generic_addr_struct align(1),
    reset_value: u8 align(1),

    reserved3: [3]u8 align(1),

    // 64-bit pointers available on ACPI 2.0+

    x_firmware_control: u64 align(1),
    x_dsdt: u64 align(1),

    x_pm1a_event_block: generic_addr_struct align(1),
    x_pm1b_event_block: generic_addr_struct align(1),
    x_pm1a_control_block: generic_addr_struct align(1),
    x_pm1b_control_block: generic_addr_struct align(1),
    x_pm2_control_block: generic_addr_struct align(1),
    x_pm_timer_block: generic_addr_struct align(1),
    x_gpe0_block: generic_addr_struct align(1),
    x_gpe1_block: generic_addr_struct align(1),
};

var fadt_struct: *fadt = undefined;
var initialized = false;

pub fn init() void {
    var rsdp_struct = @intToPtr(*rsdp, arch.architecture.acpiRsdpAddress);

    if (rsdp_struct.revision != 0) {
        terminal.writeLine("[acpi] detected version 2.0+");

        var rsdp_20_struct = @intToPtr(*rsdp_20, arch.architecture.acpiRsdpAddress);
        var xsdt_struct = @intToPtr(*xsdt, @intCast(usize, rsdp_20_struct.xsdt_address));
        var length: usize = @intCast(usize, (xsdt_struct.header.length - @sizeOf(std_header)) / 8);
        var index: usize = 0;

        while (index < length) : (index += 1) {
            var address = @intCast(usize, xsdt_struct.other_sdt_headers[index]);
            var header = @intToPtr(*std_header, address);

            if (std.mem.eql(u8, header.signature[0..4], "FACP")) {
                terminal.writeLine("[acpi] found fadt");

                fadt_struct = @intToPtr(*fadt, address);
                initialized = true;

                break;
            }
        }
    } else {
        terminal.writeLine("[acpi] detected version 1.0");

        var rsdt_struct = @intToPtr(*rsdt, rsdp_struct.rsdt_address);
        var length: usize = @intCast(usize, (rsdt_struct.header.length - @sizeOf(std_header)) / 4);
        var index: usize = 0;

        while (index < length) : (index += 1) {
            var address = rsdt_struct.other_sdt_headers[index];
            var header = @intToPtr(*std_header, address);

            if (std.mem.eql(u8, header.signature[0..4], "FACP")) {
                terminal.writeLine("[acpi] found fadt");

                fadt_struct = @intToPtr(*fadt, address);
                initialized = true;

                break;
            }
        }
    }
}

pub fn enable() void {
    if (!initialized) {
        terminal.writeLine("[acpi] enable not supported");
        return;
    }

    arch.port.outb(@truncate(u16, fadt_struct.smi_command_port), fadt_struct.acpi_enable);
    while ((arch.port.inw(@truncate(u16, fadt_struct.pm1a_control_block)) & 1) == 0) {} // Wait for ACPI to be enabled
}

pub fn disable() void {
    if (!initialized) {
        terminal.writeLine("[acpi] disable not supported");
        return;
    }

    arch.port.outb(@truncate(u16, fadt_struct.smi_command_port), fadt_struct.acpi_disable);
    while ((arch.port.inw(@truncate(u16, fadt_struct.pm1a_control_block)) & 1) != 0) {} // Wait for ACPI to be disabled
}

pub fn shutdown() void {
    if (!initialized) {
        terminal.writeLine("[acpi] shutdown not supported");
        return;
    }

    // TODO
}

pub fn reset() void {
    if (!initialized) {
        terminal.writeLine("[acpi] reset not supported");
        return;
    }

    if (fadt_struct.header.revision < 2) {
        terminal.writeLine("[acpi] reset not supported due to old version");
        return;
    }

    if ((fadt_struct.flags & (1 << 10)) == 0) {
        terminal.writeLine("[acpi] reset not supported due to feature not supported");
        return;
    }

    arch.port.outb(@truncate(u16, fadt_struct.reset_reg.address), fadt_struct.reset_value);
}
