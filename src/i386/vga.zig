const color = @import("../utils/color.zig");
const port = @import("port.zig");

pub var width: usize = undefined;
pub var height: usize = undefined;

var buffer: [*]volatile u16 = undefined;

pub fn init() void {
    width = 80;
    height = 25;
    buffer = @intToPtr([*]volatile u16, 0xB8000);
}

pub fn putCharAt(c: u8, foreground_color: color.screenColor, background_color: color.screenColor, x: usize, y: usize) void {
    var new_color = @as(u8, @enumToInt(foreground_color)) | (@as(u8, @enumToInt(background_color)) << 4);
    var entry = c | (@as(u16, new_color) << 8);

    buffer[y * width + x] = entry;
}

pub fn setCursor(x: usize, y: usize) void {
    var position = y * width + x;

    port.outb(0x3D4, 0x0F);
    port.outb(0x3D5, @intCast(u8, position & 0xFF));

    port.outb(0x3D4, 0x0E);
    port.outb(0x3D5, @intCast(u8, (position >> 8) & 0xFF));
}

pub fn scrollUp() void {
    for (1..height) |y| {
        for (0..width) |x| {
            buffer[(y - 1) * width + x] = buffer[y * width + x];
        }
    }
}
