const pmm = @import("../memory/pmm.zig");

const PAGE_DIRECTORY_SIZE = 1024;
const PAGE_TABLE_SIZE = 1024;

extern fn load_page_directory(address: usize) void;
extern fn enable_paging() void;

pub fn init() void {
    var page_directory_address = pmm.allocate(PAGE_DIRECTORY_SIZE * @sizeOf(u32));
    var page_directory_pointer = @intToPtr([*]u32, page_directory_address);

    // Mark each page table entry as "not present"
    for (0..PAGE_DIRECTORY_SIZE) |i| {
        page_directory_pointer[i] = 2;
    }

    // One page table maps 4 MiB of RAM
    var page_table_address = pmm.allocate(PAGE_TABLE_SIZE * @sizeOf(u32));
    var page_table_pointer = @intToPtr([*]u32, page_table_address);

    // Start address, here it's 0
    var address: usize = 0;

    for (0..PAGE_TABLE_SIZE) |i| {
        // The "3" here means "Supervisor level, Read/Write and Present"
        page_table_pointer[i] = (@as(u32, address) * 0x1000) | 3;
        address += 1;
    }

    // Set the first page table entry in the page directory
    page_directory_pointer[0] = @as(u32, page_table_address) | 3;

    // Load the page directory address and enable paging
    load_page_directory(page_directory_address);
    enable_paging();
}
