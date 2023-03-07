#!/bin/sh

mkdir bin

nasm -f elf32 boot/entry.asm -o bin/entry.o
nasm -f elf32 boot/helpers.asm -o bin/helpers.o
nasm -f elf32 boot/irqs.asm -o bin/irqs.o

i686-elf-gcc -c src/main.c -o bin/main.o -std=gnu2x -ffreestanding -O2 -Wall -Wextra
i686-elf-gcc -c src/std.c -o bin/std.o -std=gnu2x -ffreestanding -O2 -Wall -Wextra
i686-elf-gcc -c src/gdt.c -o bin/gdt.o -std=gnu2x -ffreestanding -O2 -Wall -Wextra
i686-elf-gcc -c src/idt.c -o bin/idt.o -std=gnu2x -ffreestanding -O2 -Wall -Wextra
i686-elf-gcc -c src/port.c -o bin/port.o -std=gnu2x -ffreestanding -O2 -Wall -Wextra
i686-elf-gcc -c src/pic.c -o bin/pic.o -std=gnu2x -ffreestanding -O2 -Wall -Wextra
i686-elf-gcc -c src/panic.c -o bin/panic.o -std=gnu2x -ffreestanding -O2 -Wall -Wextra
i686-elf-gcc -c src/drivers/vga.c -o bin/vga.o -std=gnu2x -ffreestanding -O2 -Wall -Wextra
i686-elf-gcc -c src/drivers/ps2.c -o bin/ps2.o -std=gnu2x -ffreestanding -O2 -Wall -Wextra
i686-elf-gcc -c src/apps/shell.c -o bin/shell.o -std=gnu2x -ffreestanding -O2 -Wall -Wextra
i686-elf-gcc -c src/utils/scan_map.c -o bin/scan_map.o -std=gnu2x -ffreestanding -O2 -Wall -Wextra
i686-elf-gcc -c src/memory/pmm.c -o bin/pmm.o -std=gnu2x -ffreestanding -O2 -Wall -Wextra

mkdir bin/iso

i686-elf-gcc -T linker.ld -o bin/iso/EeeOS.bin -ffreestanding -O2 -nostdlib bin/*.o -lgcc

cp limine/limine.cfg limine/limine.sys limine/limine-cd.bin bin/iso/
xorriso -as mkisofs -b limine-cd.bin -no-emul-boot -boot-load-size 4 -boot-info-table bin/iso -o EeeOS.iso

limine/limine-deploy EeeOS.iso

qemu-system-i386 -enable-kvm -m 128M -cdrom EeeOS.iso