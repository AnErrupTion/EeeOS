[bits 32]

section .text

global load_gdt
align 4

load_gdt:
    mov eax, [esp + 4]
    lgdt [eax]
    jmp 0x08:jmp_done
jmp_done:
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    ret

global load_idt
align 4

load_idt:
    mov eax, [esp + 4]
    lidt [eax]
    ret