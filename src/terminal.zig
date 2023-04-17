const graphics = @import("arch.zig").graphics;
const color = @import("utils/color.zig");

pub var width: usize = undefined;
pub var height: usize = undefined;

var row: usize = 0;
var column: usize = 0;

pub var foregroundColor = color.screenColor.white;
pub var backgroundColor = color.screenColor.black;

pub fn clear() void {
    // Clear screen
    var y: usize = 0;

    while (y < height) : (y += 1) {
        var x: usize = 0;

        while (x < width) : (x += 1) {
            graphics.putCharAt(' ', foregroundColor, backgroundColor, x, y);
        }
    }

    // Reset cursor
    graphics.setCursor(0, 0);

    // Reset position
    column = 0;
    row = 0;
}

pub fn init() void {
    graphics.init();

    width = graphics.width;
    height = graphics.height;

    clear();
}

pub fn putChar(c: u8) void {
    if (row == height - 1) {
        graphics.scrollUp();
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
        '\t' => {
            column += 4;
        },
        else => {
            graphics.putCharAt(c, foregroundColor, backgroundColor, column, row);
            column += 1;
            graphics.setCursor(column, row);
        },
    }

    if (column >= width) {
        column = 0;
        row += 1;

        if (row >= height) {
            row = 0;
        }
    }
}

pub fn write(data: []const u8) void {
    for (data) |c| {
        putChar(c);
    }
}

pub fn writeLine(data: []const u8) void {
    for (data) |c| {
        putChar(c);
    }

    newLine();
}

pub fn newLine() void {
    column = 0;
    row += 1;
}

pub fn backspace() void {
    column -= 1;
    graphics.putCharAt(' ', foregroundColor, backgroundColor, column, row);
    graphics.setCursor(column, row);
}
