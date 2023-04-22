const std = @import("std");
const multiboot = @import("../multiboot.zig");
const stack = @import("../stack.zig");

pub const PAGE_SIZE = 4096;
const BITMAP_UNIT_SIZE = 8;
const bitmap_unit = u8;

const map = struct { address: usize, size: usize };
const address_range = struct { from: usize, to: usize };

var bitmap: [*]allowzero volatile bitmap_unit = undefined;

var number_of_maps: usize = 0;
var total_pages: usize = 0;
var bitmap_size: usize = 0;
var number_of_pages: usize = 0;
pub var pages_in_use: usize = 0;
pub var total_size: usize = 0;

fn initialize_bitmap(best_map_address: usize, unavailable_address_range: []address_range, size: usize) void {
    bitmap = @intToPtr([*]allowzero volatile bitmap_unit, best_map_address);

    // Initialize bitmap by marking unavailable pages as "allocated", else setting them free
    var index: usize = 0;
    var address: usize = 0;

    while (index < bitmap_size) : (index += 1) {
        var unit: bitmap_unit = 0;
        var unit_index: usize = 0;

        while (unit_index < BITMAP_UNIT_SIZE) : (unit_index += 1) {
            var size_index: usize = 0;

            while (size_index < size) : (size_index += 1) {
                var range = unavailable_address_range[size_index];

                // The address is in an unavailable range, mark it as "allocated"
                if (address > range.from and address < range.to) {
                    unit |= @intCast(u8, @as(u16, 1) << @intCast(u4, unit_index));
                }
            }

            address += PAGE_SIZE;
        }

        bitmap[index] = unit;
    }

    // Reserve number_of_pages pages for bitmap, in the bitmap itself
    var satisfied_pages: usize = 0;
    index = 0;

    while (true) : (index += 1) {
        var unit = bitmap[index];
        var unit_index: usize = 0;

        while (unit_index < BITMAP_UNIT_SIZE) : (unit_index += 1) {
            // We have allocated the required number of pages, we can safely return the buffer now.
            if (satisfied_pages == number_of_pages) {
                return;
            }

            var mask = @intCast(u8, @as(u16, 1) << @intCast(u4, unit_index));

            // We found a free page!
            if ((unit & mask) == 0) {
                satisfied_pages += 1;
                unit |= mask;
                bitmap[index] = unit;
            }
            // This should never happen
            else {
                std.debug.panic("[pmm] found allocated page while trying to allocate bitmap", .{});
                return;
            }
        }
    }
}

//https://github.com/limine-bootloader/limine/blob/886523359c85aa10691e6b82229c91f31f21a04f/common/lib/misc.h#L66
fn div_round_up(a: usize, b: usize) usize {
    return (a + (b - 1)) / b;
}

pub fn init(max_memory_address: usize, memory_map: [*]multiboot.MultibootMemoryMapEntry, memory_map_length: usize) void {
    // Get a temporary fixed buffer allocator for the stack
    var fba = std.heap.FixedBufferAllocator.init(&stack.buffer);

    const allocator = fba.allocator();

    // Find all available memory map entries
    const memory_maps = allocator.alloc(map, memory_map_length) catch unreachable;

    defer allocator.free(memory_maps);

    var index: usize = 0;

    while (index < memory_map_length) : (index += 1) {
        var entry = memory_map[index];

        // See https://en.wikipedia.org/wiki/PCI_hole
        if (entry.type == 1 and entry.address <= max_memory_address) { // Available && writable
            var current_map = map{ .address = @intCast(usize, entry.address), .size = @intCast(usize, entry.size) };

            memory_maps[number_of_maps] = current_map;

            number_of_maps += 1;
            total_size += @intCast(usize, entry.size);
        }
    }

    // Calculate the required values
    total_pages = total_size / PAGE_SIZE;
    bitmap_size = div_round_up(total_pages, BITMAP_UNIT_SIZE);
    number_of_pages = div_round_up(bitmap_size, PAGE_SIZE);

    // Find a memory map for bitmap
    var best_map: map = undefined;
    var found_map = false;

    index = 0;

    for (memory_maps) |map_entry| {
        if (bitmap_size <= map_entry.size) {
            best_map = map_entry;
            found_map = true;
            break;
        }
    }

    if (!found_map) {
        std.debug.panic("[pmm] not enough memory to initialize", .{});
        return;
    }

    // Find all unavailable address ranges
    const unavailable_address_ranges = allocator.alloc(address_range, memory_map_length) catch unreachable;

    defer allocator.free(unavailable_address_ranges);

    var last_memory_map: map = memory_maps[0];
    var range_size: usize = 0;

    index = 1;

    if (number_of_maps > 1) {
        while (index < number_of_maps) : (index += 1) {
            var mem_map = memory_maps[index];
            var range = address_range{ .from = last_memory_map.address + last_memory_map.size, .to = mem_map.address };

            unavailable_address_ranges[range_size] = range;
            last_memory_map = mem_map;

            range_size += 1;
        }
    }

    // Initialize the bitmap with the memory map (and the unavailable address range) we found
    initialize_bitmap(best_map.address, unavailable_address_ranges, range_size);

    // At this point, we are using number_of_pages pages
    pages_in_use = number_of_pages;
}

pub fn allocate(size: usize) usize {
    // Calculate the required values
    var sz = size;
    while (sz % PAGE_SIZE != 0) {
        sz += 1;
    }

    var required_pages = sz / PAGE_SIZE;
    var satisfied_pages: usize = 0;
    var index: usize = 0;
    var address: usize = 0;

    while (true) : (index += 1) {
        var unit = bitmap[index];
        var unit_index: usize = 0;

        while (unit_index < BITMAP_UNIT_SIZE) : (unit_index += 1) {
            // We have allocated the required number of pages, we can safely return the buffer now.
            if (satisfied_pages == required_pages) {
                pages_in_use += satisfied_pages;
                return address;
            }

            var mask = @intCast(u8, @as(u16, 1) << @intCast(u4, unit_index));

            // We found a free page!
            if ((unit & mask) == 0) {
                satisfied_pages += 1;
                unit |= mask;
                bitmap[index] = unit;
            }
            // Either we still didn't find a free page, or the next page is allocated.
            else {
                address += PAGE_SIZE;
                satisfied_pages = 0;
            }
        }
    }
}

pub fn free(buffer_address: usize, size: usize) void {
    // Calculate the required values
    var sz = size;
    while (sz % PAGE_SIZE != 0) {
        sz += 1;
    }

    var required_pages = sz / PAGE_SIZE;
    var satisfied_pages: usize = 0;
    var index: usize = 0;
    var address: usize = 0;

    while (true) : (index += 1) {
        var unit = bitmap[index];
        var unit_index: usize = 0;

        while (unit_index < BITMAP_UNIT_SIZE) : (unit_index += 1) {
            // We have freed the required number of pages, we can safely return now.
            if (satisfied_pages == required_pages) {
                pages_in_use -= satisfied_pages;
                return;
            }

            if (address == buffer_address) {
                satisfied_pages += 1;
                unit &= ~(@intCast(u8, @as(u16, 1) << @intCast(u4, unit_index)));
                bitmap[index] = unit;
            } else {
                address += PAGE_SIZE;
            }
        }
    }
}
