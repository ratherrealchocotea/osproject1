ENTRY(_start)

MEMORY
{
    stage1 (rwx) : ORIGIN = 0x7c00, LENGTH = 512
    stage2 (rwx) : ORIGIN = 0x7e00, LENGTH = 512
    kernel (rwx) : ORIGIN = 0x8000, LENGTH = 0x10000
}

SECTIONS
{
    .stage1 : { *(.stage1); } > stage1
    .stage2 : { *(.stage2); } > stage2
    text : { *(.text); } > kernel
    .data : { *(.data); } > kernel  
    .rodata : { *(.rodata); } > kernel  
    .bss :
    {
        *(.bss)
        *(COMMON)
    } > kernel
}
