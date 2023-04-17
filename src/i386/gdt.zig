const std = @import("std");
const stack = @import("../stack.zig");

const GDT_ENTRIES = 3;

const gdt_entry = packed struct {
    limit_low: u16,
    base_low: u16,
    base_middle: u8,
    access: u8,
    granularity: u8,
    base_high: u8,
};
const gdtr = packed struct { size: u16, offset: u32 };

extern fn load_gdt(gdt: usize) void;

fn create_entry(address: u32, limit: u32, access: u8, granularity: u8) gdt_entry {
    var gdt = stack.allocator.create(gdt_entry) catch unreachable;
    stack.allocated_bytes += @sizeOf(gdt_entry);

    gdt.base_low = @intCast(u16, address & 0xFFFF);
    gdt.base_middle = @intCast(u8, (address >> 16) & 0xFF);
    gdt.base_high = @intCast(u8, (address >> 24) & 0xFF);
    gdt.limit_low = @intCast(u16, limit & 0xFFFF);
    gdt.granularity = @intCast(u8, @intCast(u8, (limit >> 16) & 0x0F) | (granularity & 0xF0));
    gdt.access = access;

    return gdt.*;
}

pub fn init() void {
    // Initialize buffer and add all segments
    var gdt_entries = stack.allocator.alloc(gdt_entry, GDT_ENTRIES) catch unreachable;
    stack.allocated_bytes += GDT_ENTRIES * @sizeOf(gdt_entry);

    gdt_entries[0] = create_entry(0, 0, 0, 0); // Null segment
    gdt_entries[1] = create_entry(0, 0xFFFFFFFF, 0x9A, 0xCF); // Code segment
    gdt_entries[2] = create_entry(0, 0xFFFFFFFF, 0x92, 0xCF); // Data segment

    // Load GDT
    var gdt = stack.allocator.create(gdtr) catch unreachable;
    stack.allocated_bytes += @sizeOf(gdtr);

    gdt.size = (GDT_ENTRIES * @sizeOf(gdt_entry)) - 1;
    gdt.offset = @as(u32, @ptrToInt(&gdt_entries[0]));

    load_gdt(@ptrToInt(gdt));
}
