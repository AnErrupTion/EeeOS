const std = @import("std");
const vga = @import("../vga.zig");
const ps2 = @import("../ps2.zig");
const acpi = @import("../drivers/acpi.zig");
const pmm = @import("../memory/pmm.zig");
const scanmap = @import("../utils/scanmap.zig");

const BUFFER_SIZE = 4096;

var buffer: [BUFFER_SIZE]u8 = undefined;

fn read_line() usize {
    var index: usize = 0;

    while (true) {
        var scan_code = ps2.getScanCode();

        if (scan_code == 0) {
            continue;
        }

        var key = scanmap.getKey(scan_code);

        if (key.type == .unknown) {
            continue;
        }

        if (key.type == .backspace) {
            if (index > 0) {
                index -= 1;
                buffer[index] = ' ';
                vga.backspace();
            }

            continue;
        }

        if (key.type == .enter) {
            vga.newLine();
            return index;
        }

        buffer[index] = key.value;
        vga.putChar(key.value);

        index += 1;
    }
}

pub fn exec() void {
    const format_buffer_size = 1024;

    var format_buffer: [format_buffer_size]u8 = undefined;

    while (true) {
        vga.write("> ");

        var size = read_line();
        var command = buffer[0..size];

        if (std.mem.eql(u8, command, "help")) {
            vga.writeLine(
                \\help - Shows all commands.
                \\usedram - Shows the amount of used RAM, in KiB.
                \\totalram - Shows the total amount of usable RAM, in MiB.
                \\shutdown - Shuts down the computer via ACPI.
                \\reset - Resets the computer via ACPI.
            );
        } else if (std.mem.eql(u8, command, "clear")) {
            vga.clear();
        } else if (std.mem.eql(u8, command, "usedram")) {
            var format = std.fmt.bufPrint(&format_buffer, "RAM in use: {d} kiB", .{pmm.pages_in_use * pmm.PAGE_SIZE / 1024}) catch unreachable;
            vga.writeLine(format);
        } else if (std.mem.eql(u8, command, "totalram")) {
            var format = std.fmt.bufPrint(&format_buffer, "Total usable RAM: {d} MiB", .{pmm.total_size / 1024 / 1024}) catch unreachable;
            vga.writeLine(format);
        } else if (std.mem.eql(u8, command, "shutdown")) {
            vga.writeLine("Shutting down...");
            acpi.shutdown();
        } else if (std.mem.eql(u8, command, "reset")) {
            vga.writeLine("Resetting...");
            acpi.reset();
        } else {
            vga.write("Unknown command: ");
            vga.writeLine(command);
        }
    }
}
