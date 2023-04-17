const Multiboot = extern struct {
    magic: u32 align(1),
    flags: u32 align(1),
    checksum: i32 align(1),
};

const ALIGN = 1 << 0;
const MEMINFO = 1 << 1;
const MAGIC = 0x1BADB002;
const FLAGS = ALIGN | MEMINFO;

export var multiboot align(4) linksection(".multiboot") = Multiboot{
    .magic = MAGIC,
    .flags = FLAGS,
    .checksum = -(MAGIC + FLAGS),
};

pub const MultibootMemoryMapEntry = extern struct {
    ent_size: u32 align(1),
    address: u64 align(1),
    size: u64 align(1),
    type: u32 align(1),
};
pub const MultibootModule = extern struct {
    address_start: u32 align(1),
    address_end: u32 align(1),
    string: u32 align(1),
    reserved: u32 align(1),
};
pub const MultibootVbeControlInfo = extern struct {
    signature: [4]u8 align(1),
    version: u16 align(1),
    oemstr: [2]u16 align(1),
    capabilities: [4]u8 align(1),
    videomode: [2]u16 align(1),
    totalmem: u16 align(1),
};
pub const MultibootVbeModeInfo = extern struct {
    attributes: u16 align(1),
    window_a: u8 align(1),
    window_b: u8 align(1),
    granularity: u16 align(1),
    window_size: u16 align(1),
    segment_a: u16 align(1),
    segment_b: u16 align(1),
    window_func: [2]u16 align(1),
    pitch: u16 align(1),
    width: u16 align(1),
    height: u16 align(1),
    char_width: u8 align(1),
    char_height: u8 align(1),
    planes: u8 align(1),
    depth: u8 align(1),
    banks: u8 align(1),
    memory_model: u8 align(1),
    bank_size: u8 align(1),
    image_pages: u8 align(1),
    reserved0: u8 align(1),
    red_mask: u8 align(1),
    red_position: u8 align(1),
    green_mask: u8 align(1),
    green_position: u8 align(1),
    blue_mask: u8 align(1),
    blue_position: u8 align(1),
    rsv_mask: u8 align(1),
    rsv_position: u8 align(1),
    direct_color: u8 align(1),
    physical_base: u32 align(1),
    reserved1: u32 align(1),
    reserved2: u16 align(1),
};
pub const MultibootInfo = extern struct {
    flags: u32 align(1),
    memory_lower: u32 align(1),
    memory_upper: u32 align(1),
    boot_device: u32 align(1),
    command_line: [*:0]const u8 align(1),
    modules_count: u32 align(1),
    modules: [*]MultibootModule align(1),
    syms: [4]u32 align(1),
    memory_map_length: u32 align(1),
    memory_map: [*]MultibootMemoryMapEntry align(1),
    drives_count: u32 align(1),
    drives_addr: u32 align(1),
    config_table: u32 align(1),
    bootloader_name: [*:0]const u8 align(1),
    table: u32 align(1),
    vbe_control_info: [*]MultibootVbeControlInfo align(1),
    vbe_mode_info: [*]MultibootVbeModeInfo align(1),
    vbe_mode: u32 align(1),
    vbe_interface_seg: u32 align(1),
    vbe_interface_offset: u32 align(1),
    vbe_interface_length: u32 align(1),
};
