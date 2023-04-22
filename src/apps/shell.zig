const std = @import("std");
const terminal = @import("../terminal.zig");
const arch = @import("../arch.zig");
const acpi = @import("../drivers/acpi.zig");
const pmm = @import("../memory/pmm.zig");
const scanmap = @import("../utils/scanmap.zig");

const BUFFER_SIZE = 1024;

var buffer: []u8 = undefined;

fn read_line() usize {
    var index: usize = 0;

    while (true) {
        var scan_code = arch.keyboard.getScanCode();

        if (scan_code == 0) {
            continue;
        }

        var key = scanmap.getKey(scan_code);

        if (key.type == scanmap.key_type.unknown) {
            continue;
        }

        if (key.type == scanmap.key_type.backspace) {
            if (index > 0) {
                index -= 1;
                buffer[index] = ' ';
                terminal.backspace();
            }

            continue;
        }

        if (key.type == scanmap.key_type.enter) {
            terminal.newLine();
            return index;
        }

        buffer[index] = key.value;
        terminal.putChar(key.value);

        index += 1;
    }
}

pub fn exec() void {
    var buffer_address = pmm.allocate(BUFFER_SIZE);
    var buffer_pointer = @intToPtr([*]u8, buffer_address);

    buffer = buffer_pointer[0..BUFFER_SIZE];

    const format_buffer_size = 1024;

    var format_buffer_pointer = @intToPtr([*]u8, pmm.allocate(format_buffer_size));
    var format_buffer = format_buffer_pointer[0..format_buffer_size];

    while (true) {
        terminal.write("> ");

        var size = read_line();
        var command = buffer[0..size];

        if (std.mem.eql(u8, command, "help")) {
            terminal.writeLine(
                \\help - Shows all commands.
                \\usedram - Shows the amount of used RAM, in KiB.
                \\totalram - Shows the total amount of usable RAM, in MiB.
                \\shutdown - Shuts down the computer via ACPI.
                \\reset - Resets the computer via ACPI.
            );
        } else if (std.mem.eql(u8, command, "clear")) {
            terminal.clear();
        } else if (std.mem.eql(u8, command, "usedram")) {
            var format = std.fmt.bufPrint(format_buffer, "RAM in use: {d}K", .{pmm.pages_in_use * pmm.PAGE_SIZE / 1024}) catch unreachable;
            terminal.writeLine(format);
        } else if (std.mem.eql(u8, command, "totalram")) {
            var format = std.fmt.bufPrint(format_buffer, "Total usable RAM: {d}M", .{pmm.total_size / 1024 / 1024}) catch unreachable;
            terminal.writeLine(format);
        } else if (std.mem.eql(u8, command, "shutdown")) {
            terminal.writeLine("Shutting down...");
            acpi.shutdown();
        } else if (std.mem.eql(u8, command, "reset")) {
            terminal.writeLine("Resetting...");
            acpi.reset();
        } else {
            terminal.write("Unknown command: ");
            terminal.writeLine(command);
        }
    }
}
