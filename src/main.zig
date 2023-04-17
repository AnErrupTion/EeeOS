const std = @import("std");
const multiboot = @import("multiboot.zig");
const terminal = @import("terminal.zig");
const pmm = @import("memory/pmm.zig");
const arch = @import("arch.zig");
const acpi = @import("drivers/acpi.zig");
const shell = @import("apps/shell.zig");

pub fn panic(msg: []const u8, error_return_trace: ?*std.builtin.StackTrace, siz: ?usize) noreturn {
    _ = error_return_trace;
    _ = siz;

    @setCold(true);

    terminal.write("PANIC: ");
    terminal.write(msg);

    while (true) {}
}

export fn kmain(multiboot_info: *const multiboot.MultibootInfo) noreturn {
    terminal.init();

    terminal.writeLine("[pmm] init");
    pmm.init(multiboot_info.memory_upper * 1024, multiboot_info.memory_map, multiboot_info.memory_map_length);

    terminal.writeLine("[arch] init");
    arch.architecture.init();

    if (arch.architecture.acpiRsdpAddress != undefined) {
        terminal.writeLine("[acpi] init");
        acpi.init();

        terminal.writeLine("[acpi] enable");
        acpi.enable();
    }

    terminal.writeLine("[shell] exec");
    shell.exec();

    while (true) {}
}
