const color = @import("utils/color.zig");
const port = @import("utils/port.zig");

pub const WIDTH: usize = 80;
pub const HEIGHT: usize = 25;

const BUFFER = @as([*]volatile u16, @ptrFromInt(0xB8000));

pub var foregroundColor = color.ScreenColor.white;
pub var backgroundColor = color.ScreenColor.black;

var row: usize = 0;
var column: usize = 0;

pub fn clear() void {
    // Clear screen
    for (0..HEIGHT) |y| {
        for (0..WIDTH) |x| {
            putCharAt(' ', foregroundColor, backgroundColor, x, y);
        }
    }

    // Reset cursor
    setCursor(0, 0);

    // Reset position
    column = 0;
    row = 0;
}

pub fn putChar(c: u8) void {
    if (row == HEIGHT - 1) {
        scrollUp();
        row -= 1;
    }

    switch (c) {
        '\n' => {
            column = 0;
            row += 1;
            return;
        },
        '\r' => {
            column = 0;
            return;
        },
        '\t' => column += 4,
        else => {
            putCharAt(c, foregroundColor, backgroundColor, column, row);
            column += 1;
            setCursor(column, row);
        },
    }

    if (column >= WIDTH) {
        column = 0;
        row += 1;

        if (row >= HEIGHT) row = 0;
    }
}

pub fn write(data: []const u8) void {
    for (data) |c| putChar(c);
}

pub fn writeLine(data: []const u8) void {
    for (data) |c| putChar(c);
    newLine();
}

pub fn newLine() void {
    column = 0;
    row += 1;
}

pub fn backspace() void {
    column -= 1;
    putCharAt(' ', foregroundColor, backgroundColor, column, row);
    setCursor(column, row);
}

pub fn putCharAt(c: u8, foreground_color: color.ScreenColor, background_color: color.ScreenColor, x: usize, y: usize) void {
    const new_color = @as(u8, @intFromEnum(foreground_color)) | (@as(u8, @intFromEnum(background_color)) << 4);
    const entry = c | (@as(u16, new_color) << 8);

    BUFFER[y * WIDTH + x] = entry;
}

pub fn setCursor(x: usize, y: usize) void {
    const position = y * WIDTH + x;

    port.outb(0x3D4, 0x0F);
    port.outb(0x3D5, @as(u8, @intCast(position & 0xFF)));

    port.outb(0x3D4, 0x0E);
    port.outb(0x3D5, @as(u8, @intCast((position >> 8) & 0xFF)));
}

pub fn scrollUp() void {
    for (1..HEIGHT) |y| {
        for (0..WIDTH) |x| {
            BUFFER[(y - 1) * WIDTH + x] = BUFFER[y * WIDTH + x];
        }
    }
}
