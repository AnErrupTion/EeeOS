pub const SIZE: usize = 16 * 1024;

pub export var buffer: [SIZE]u8 align(16) linksection(".bss") = undefined;