pub const key_type = enum { unknown, normal, enter, backspace };
pub const key = struct { type: key_type, value: u8 };

pub fn getKey(scan_code: u8) key {
    var newKey: key = undefined;

    switch (scan_code) {
        14 => {
            newKey = .{ .type = key_type.backspace, .value = 0 };
        },
        16 => {
            newKey = .{ .type = key_type.normal, .value = 'q' };
        },
        17 => {
            newKey = .{ .type = key_type.normal, .value = 'w' };
        },
        18 => {
            newKey = .{ .type = key_type.normal, .value = 'e' };
        },
        19 => {
            newKey = .{ .type = key_type.normal, .value = 'r' };
        },
        20 => {
            newKey = .{ .type = key_type.normal, .value = 't' };
        },
        21 => {
            newKey = .{ .type = key_type.normal, .value = 'y' };
        },
        22 => {
            newKey = .{ .type = key_type.normal, .value = 'u' };
        },
        23 => {
            newKey = .{ .type = key_type.normal, .value = 'i' };
        },
        24 => {
            newKey = .{ .type = key_type.normal, .value = 'o' };
        },
        25 => {
            newKey = .{ .type = key_type.normal, .value = 'p' };
        },
        28 => {
            newKey = .{ .type = key_type.enter, .value = 0 };
        },
        30 => {
            newKey = .{ .type = key_type.normal, .value = 'a' };
        },
        31 => {
            newKey = .{ .type = key_type.normal, .value = 's' };
        },
        32 => {
            newKey = .{ .type = key_type.normal, .value = 'd' };
        },
        33 => {
            newKey = .{ .type = key_type.normal, .value = 'f' };
        },
        34 => {
            newKey = .{ .type = key_type.normal, .value = 'g' };
        },
        35 => {
            newKey = .{ .type = key_type.normal, .value = 'h' };
        },
        36 => {
            newKey = .{ .type = key_type.normal, .value = 'j' };
        },
        37 => {
            newKey = .{ .type = key_type.normal, .value = 'k' };
        },
        38 => {
            newKey = .{ .type = key_type.normal, .value = 'l' };
        },
        44 => {
            newKey = .{ .type = key_type.normal, .value = 'z' };
        },
        45 => {
            newKey = .{ .type = key_type.normal, .value = 'x' };
        },
        46 => {
            newKey = .{ .type = key_type.normal, .value = 'c' };
        },
        47 => {
            newKey = .{ .type = key_type.normal, .value = 'v' };
        },
        48 => {
            newKey = .{ .type = key_type.normal, .value = 'b' };
        },
        49 => {
            newKey = .{ .type = key_type.normal, .value = 'n' };
        },
        50 => {
            newKey = .{ .type = key_type.normal, .value = 'm' };
        },
        57 => {
            newKey = .{ .type = key_type.normal, .value = ' ' };
        },
        else => {
            newKey = .{ .type = key_type.unknown, .value = 0 };
        },
    }

    return newKey;
}
