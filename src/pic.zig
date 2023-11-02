const port = @import("utils/port.zig");

// Master PIC
const PIC1_COMMAND = 0x0020;
const PIC1_DATA = 0x0021;

// Slave PIC
const PIC2_COMMAND = 0x00A0;
const PIC2_DATA = 0x00A1;

// EOI command
const PIC_EOI = 0x20;

// Initialization commands
const ICW1_ICW4 = 0x01;
const ICW1_SINGLE = 0x02;
const ICW1_INTERVAL4 = 0x04;
const ICW1_LEVEL = 0x08;
const ICW1_INIT = 0x10;

const ICW4_8086 = 0x01;
const ICW4_AUTO = 0x02;
const ICW4_BUF_SLAVE = 0x08;
const ICW4_BUF_MASTER = 0x0C;
const ICW4_SFNM = 0x10;

pub fn remap(offset1: u8, offset2: u8) void {
    // Save masks
    const a1 = port.inb(PIC1_DATA);
    const a2 = port.inb(PIC2_DATA);

    // Start the initialization sequence (in cascade mode)
    port.outb(PIC1_COMMAND, ICW1_INIT | ICW1_ICW4);
    port.ioWait();
    port.outb(PIC2_COMMAND, ICW1_INIT | ICW1_ICW4);
    port.ioWait();

    // ICW2: Master PIC vector offset
    port.outb(PIC1_DATA, offset1);
    port.ioWait();

    // ICW2: Slave PIC vector offset
    port.outb(PIC2_DATA, offset2);
    port.ioWait();

    // ICW3: Tell Master PIC that there is a slave PIC at IRQ 2 (0000 0100)
    port.outb(PIC1_DATA, 4);
    port.ioWait();

    // ICW3: Tell Slave PIC its cascade identity (0000 0010)
    port.outb(PIC2_DATA, 2);
    port.ioWait();

    port.outb(PIC1_DATA, ICW4_8086);
    port.ioWait();
    port.outb(PIC2_DATA, ICW4_8086);
    port.ioWait();

    // Restore masks
    port.outb(PIC1_DATA, a1);
    port.outb(PIC2_DATA, a2);
}

pub fn init() void {
    remap(0x20, 0x28);
}

pub fn disable() void {
    port.outb(PIC2_DATA, 0xFF);
    port.outb(PIC1_DATA, 0xFF);
}

pub fn sendEoi(irq: u8) void {
    // One PIC can only handle 8 IRQs
    if (irq >= 8) port.outb(PIC2_COMMAND, PIC_EOI);
    port.outb(PIC1_COMMAND, PIC_EOI);
}

pub fn setIrqMask(irq: u8) void {
    var portq: u16 = 0;
    var intr = irq;

    if (intr < 8) {
        portq = PIC1_DATA;
    } else {
        portq = PIC2_DATA;
        intr -= 8;
    }

    const value = port.inb(portq) | @as(u8, @intCast(@as(u16, 1) << @as(u4, @intCast(intr))));
    port.outb(portq, value);
}

pub fn clearIrqMask(irq: u8) void {
    var portq: u16 = 0;
    var intr = irq;

    if (intr < 8) {
        portq = PIC1_DATA;
    } else {
        portq = PIC2_DATA;
        intr -= 8;
    }

    const value = port.inb(portq) & ~@as(u8, @intCast(@as(u16, 1) << @as(u4, @intCast(intr))));
    port.outb(portq, value);
}
