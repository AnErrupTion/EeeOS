.global _start
.type _start, @function
.align 4

_start:
    mov $0x80000, %esp

    push %ebx

    call kmain

    cli
    hlt
