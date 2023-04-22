const pmm = @import("../memory/pmm.zig");

const PAGE_DIRECTORY_SIZE = 1024 * @sizeOf(u32);
const PAGE_TABLE_SIZE = 1024 * @sizeOf(u32);

pub fn init() void {
    var page_directory_address = pmm.allocate(PAGE_DIRECTORY_SIZE);
    _ = page_directory_address;
    var page_table_address = pmm.allocate(PAGE_TABLE_SIZE);
    _ = page_table_address;
}
