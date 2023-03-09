#!/bin/sh

C_FLAGS="-std=gnu2x -ffreestanding -O2 -Wall -Wextra"

mkdir bin

nasm -f elf32 boot/i686/entry.asm -o bin/entry.o
nasm -f elf32 boot/i686/helpers.asm -o bin/helpers.o
nasm -f elf32 boot/i686/irqs.asm -o bin/irqs.o

i686-elf-gcc -c src/x86/i686/gdt.c -o bin/gdt.o ${C_FLAGS}
i686-elf-gcc -c src/x86/i686/idt.c -o bin/idt.o ${C_FLAGS}
i686-elf-gcc -c src/x86/main.c -o bin/main.o ${C_FLAGS}
i686-elf-gcc -c src/x86/port.c -o bin/port.o ${C_FLAGS}
i686-elf-gcc -c src/x86/pic.c -o bin/pic.o ${C_FLAGS}
i686-elf-gcc -c src/x86/drivers/vga.c -o bin/vga.o ${C_FLAGS}
i686-elf-gcc -c src/x86/drivers/ps2.c -o bin/ps2.o ${C_FLAGS}
i686-elf-gcc -c src/x86/drivers/acpi.c -o bin/acpi.o ${C_FLAGS}
i686-elf-gcc -c src/std.c -o bin/std.o ${C_FLAGS}
i686-elf-gcc -c src/panic.c -o bin/panic.o ${C_FLAGS}
i686-elf-gcc -c src/apps/shell.c -o bin/shell.o ${C_FLAGS}
i686-elf-gcc -c src/utils/scan_map.c -o bin/scan_map.o ${C_FLAGS}
i686-elf-gcc -c src/memory/pmm.c -o bin/pmm.o ${C_FLAGS}

mkdir bin/iso

i686-elf-gcc -T linker.ld -o bin/iso/EeeOS.bin ${C_FLAGS} -nostdlib bin/*.o -lgcc

cp limine/limine.cfg limine/limine.sys limine/limine-cd.bin bin/iso/
xorriso -as mkisofs -b limine-cd.bin -no-emul-boot -boot-load-size 4 -boot-info-table bin/iso -o EeeOS.iso

limine/limine-deploy EeeOS.iso

qemu-system-i386 -cpu pentium2 -enable-kvm -m 128M -cdrom EeeOS.iso