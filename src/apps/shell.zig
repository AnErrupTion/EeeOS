const std = @import("std");
const stack = @import("../stack.zig");
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
    buffer = stack.allocator.alloc(u8, BUFFER_SIZE) catch unreachable;
    stack.allocated_bytes += BUFFER_SIZE;

    while (true) {
        terminal.write("> ");

        var size = read_line();
        var command = buffer[0..size];

        if (std.mem.eql(u8, command, "help")) {
            terminal.writeLine(
                \\help - Shows all commands.
                \\usedram - Shows the amount of used RAM, in KiB.
                \\totalram - Shows the total amount of usable RAM, in MiB.
                \\usedstackmem - Shows the amount of used stack memory, in KiB.
                \\totalstackmem - Shows the total amount of usable stack memory, in KiB.
                \\shutdown - Shuts down the computer via ACPI.
                \\reset - Resets the computer via ACPI.
            );
        } else if (std.mem.eql(u8, command, "clear")) {
            terminal.clear();
        } else if (std.mem.eql(u8, command, "usedram")) {
            var format = std.fmt.allocPrint(stack.allocator, "RAM in use: {d}K", .{pmm.pages_in_use * pmm.PAGE_SIZE / 1024}) catch unreachable;
            terminal.writeLine(format);
            stack.allocator.free(format);
        } else if (std.mem.eql(u8, command, "totalram")) {
            var format = std.fmt.allocPrint(stack.allocator, "Total usable RAM: {d}M", .{pmm.total_size / 1024 / 1024}) catch unreachable;
            terminal.writeLine(format);
            stack.allocator.free(format);
        } else if (std.mem.eql(u8, command, "usedstackmem")) {
            var format = std.fmt.allocPrint(stack.allocator, "Stack memory in use: {d}K", .{stack.allocated_bytes / 1024}) catch unreachable;
            terminal.writeLine(format);
            stack.allocator.free(format);
        } else if (std.mem.eql(u8, command, "totalstackmem")) {
            var format = std.fmt.allocPrint(stack.allocator, "Total usable stack memory: {d}K", .{stack.SIZE / 1024}) catch unreachable;
            terminal.writeLine(format);
            stack.allocator.free(format);
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
