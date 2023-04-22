const pic = @import("pic.zig");
const port = @import("port.zig");
const pmm = @import("../memory/pmm.zig");

const DATA_PORT = 0x60;
const STATUS_PORT = 0x64;
const COMMAND_PORT = 0x64;

const FIFO_SIZE = 256;

var fifo_buffer: []u8 = undefined;
var fifo_buffer_initialized = false;
var fifo_start: usize = 0;
var fifo_end: usize = 0;

pub fn onInterrupt() void {
    var status = port.inb(STATUS_PORT) & 0x01;

    if (status == 0x01) {
        var data = port.inb(DATA_PORT);
        var next = fifo_end + 1;

        if (next == FIFO_SIZE) {
            next = 0; // Wrap around
        }

        if (next == fifo_start) {
            return; // We're out of room
        }

        if (fifo_buffer_initialized) {
            fifo_buffer[next] = data;
            fifo_end = next;
        }
    }
}

pub fn init() void {
    // Initialize FIFO buffer
    var fifo_buffer_address = pmm.allocate(FIFO_SIZE);
    var fifo_buffer_pointer = @intToPtr([*]u8, fifo_buffer_address);

    fifo_buffer = fifo_buffer_pointer[0..FIFO_SIZE];
    fifo_buffer_initialized = true;

    // Enable keyboard handler in PIC (IRQ 1)
    pic.clearIrqMask(1);
}

pub fn getScanCode() u8 {
    if (fifo_start == fifo_end) {
        return 0;
    }

    var value = fifo_buffer[fifo_start];

    fifo_start += 1;

    if (fifo_start == FIFO_SIZE) {
        fifo_start = 0; // Wrap around
    }

    return value;
}
