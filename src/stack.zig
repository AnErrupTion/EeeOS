const std = @import("std");

pub const SIZE: usize = 16 * 1024;

export var buffer: [SIZE]u8 align(16) linksection(".bss") = undefined;

var fba = std.heap.FixedBufferAllocator.init(&buffer);

pub var allocated_bytes: usize = 0;

pub const allocator = fba.allocator();
