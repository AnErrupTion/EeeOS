[bits 32]

section .text

global load_gdt
align 4

load_gdt:
    cli
    mov eax, [esp + 4]
    lgdt [eax]
    sti
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
    cli
    mov eax, [esp + 4]
    lidt [eax]
    sti
    ret

global test_irq
align 4

test_irq:
    int 0x80
    ret