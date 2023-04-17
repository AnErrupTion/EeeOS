const std = @import("std");
const terminal = @import("../terminal.zig");

const gdt = @import("gdt.zig");
const idt = @import("idt.zig");
const pic = @import("pic.zig");
const ps2 = @import("ps2.zig");

pub var acpiRsdpAddress: usize = undefined;

pub fn init() void {
    asm volatile ("cli");

    terminal.writeLine("  [gdt] init");
    gdt.init();

    terminal.writeLine("  [idt] init");
    idt.init();

    terminal.writeLine("  [pic] init");
    pic.init();

    terminal.writeLine("  [ps2] init");
    ps2.init();

    terminal.writeLine("  [acpi] probe");

    // Find ACPI RSDP address
    var address: usize = 0x000E0000;

    while (address <= 0x000FFFFF) : (address += 16) {
        var pointer = @intToPtr([*]u8, address);
        var signature = pointer[0..8];

        if (std.mem.eql(u8, signature, "RSD PTR ")) {
            acpiRsdpAddress = address;
            terminal.writeLine("  [acpi] found");

            break;
        }
    }

    asm volatile ("sti");
}
