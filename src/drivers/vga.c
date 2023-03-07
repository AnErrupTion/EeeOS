//
// Created by anerruption on 05/03/23.
//

#include "../../include/drivers/vga.h"
#include "../../include/port.h"

enum vga_color {
    BLACK = 0,
    BLUE = 1,
    GREEN = 2,
    CYAN = 3,
    RED = 4,
    MAGENTA = 5,
    BROWN = 6,
    LIGHT_GRAY = 7,
    DARK_GRAY = 8,
    LIGHT_BLUE = 9,
    LIGHT_GREEN = 10,
    LIGHT_CYAN = 11,
    LIGHT_RED = 12,
    LIGHT_MAGENTA = 13,
    LIGHT_BROWN = 14,
    WHITE = 15
};

static const size_t VGA_WIDTH = 80;
static const size_t VGA_HEIGHT = 25;

size_t terminal_row;
size_t terminal_column;
uint8_t terminal_color;
uint16_t* terminal_buffer;

static inline uint8_t vga_entry_color(enum vga_color fg, enum vga_color bg)
{
    return fg | bg << 4;
}

static inline uint16_t vga_entry(unsigned char uc, uint8_t color)
{
    return (uint16_t) uc | (uint16_t) color << 8;
}

static void term_put(char c, uint8_t color, size_t x, size_t y)
{
    const size_t index = y * VGA_WIDTH + x;
    terminal_buffer[index] = vga_entry(c, color);
}

void term_init()
{
    terminal_row = 0;
    terminal_column = 0;
    terminal_color = vga_entry_color(LIGHT_GRAY, BLACK);
    terminal_buffer = (uint16_t*) 0xB8000;

    for (size_t y = 0; y < VGA_HEIGHT; y++)
    {
        for (size_t x = 0; x < VGA_WIDTH; x++)
        {
            const size_t index = y * VGA_WIDTH + x;
            terminal_buffer[index] = vga_entry(' ', terminal_color);
        }
    }
}

void term_set_color(uint8_t color)
{
    terminal_color = color;
}

void term_write_char(char c)
{
    // Check if the character is a special character
    if (c == '\n')
    {
        terminal_column = 0;
        terminal_row++;
        return;
    }
    else if (c == '\r')
    {
        terminal_column = 0;
        return;
    }
    else if (c == '\t')
    {
        terminal_column += 4;
        return;
    }

    // Else, print it
    term_put(c, terminal_color, terminal_column, terminal_row);

    if (++terminal_column == VGA_WIDTH)
    {
        terminal_column = 0;

        if (++terminal_row == VGA_HEIGHT)
        {
            terminal_row = 0;
        }
    }

    // And finally, update the cursor
    uint32_t location = (terminal_row * VGA_WIDTH) + terminal_column;

    outb(0x3D4, 0x0F);
    outb(0x3D5, (uint8_t)(location & 0xFF));

    outb(0x3D4, 0x0E);
    outb(0x3D5, (uint8_t)((location >> 8) & 0xFF));
}

void term_write(const char* data, size_t size)
{
    for (size_t i = 0; i < size; i++)
    {
        term_write_char(data[i]);
    }
}

void term_write_string(const char* data)
{
    term_write(data, strlen(data));
}