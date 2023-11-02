ENTRY(_start)

SECTIONS {
	. = 1M;

	.text : ALIGN(8K) {
		KEEP(*(.multiboot))
		*(.text)
	}

	.rodata : ALIGN(8K) {
		*(.rodata)
	}

	.data : ALIGN(8K) {
		*(.data)
	}

	.bss : ALIGN(8K) {
		*(COMMON)
		*(.bss)
	}
}
