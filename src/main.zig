const std = @import("std");
const vga = @import("vga.zig");
const multiboot = @import("utils/multiboot.zig");
const pmm = @import("memory/pmm.zig");
const mmu = @import("mmu.zig");
const gdt = @import("gdt.zig");
const idt = @import("idt.zig");
const pic = @import("pic.zig");
const ps2 = @import("ps2.zig");
const acpi = @import("drivers/acpi.zig");
const shell = @import("apps/shell.zig");

pub fn panic(msg: []const u8, error_return_trace: ?*std.builtin.StackTrace, siz: ?usize) noreturn {
    _ = error_return_trace;
    _ = siz;

    @setCold(true);

    vga.write("PANIC: ");
    vga.write(msg);

    while (true) {}
}

export fn kmain(multiboot_info_address: usize) noreturn {
    asm volatile ("cli");

    vga.clear();

    vga.writeLine("[multiboot] init");
    multiboot.init(multiboot_info_address);

    vga.writeLine("[pmm] init");
    pmm.init(multiboot.memoryUpper * 1024, multiboot.entries, multiboot.entryCount);

    vga.writeLine("[mmu] init");
    mmu.init();

    vga.writeLine("[gdt] init");
    gdt.init();

    vga.writeLine("[idt] init");
    idt.init();

    vga.writeLine("[pic] init");
    pic.init();

    vga.writeLine("[ps2] init");
    ps2.init();

    vga.writeLine("[acpi] init");
    acpi.init();

    vga.writeLine("[acpi] enable");
    acpi.enable();

    asm volatile ("sti");

    vga.writeLine("[shell] exec");
    shell.exec();

    while (true) {}
}
