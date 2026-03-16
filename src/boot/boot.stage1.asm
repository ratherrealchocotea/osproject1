;; boot.stage1.asm

section .stage1

global _start
[bits 16]

%include "boot.common.asm"

_start:
    mov bx, boot_msg
    call _print_string

    mov si, DAP
    mov ah, 0x42                ; Extended read function
    mov dl, 0x80                ; Drive number
    int 0x13
    jc _disk_read_err

_continue:
   ;; jmp 0x0000:0x7e00
    jmp $

_disk_read_err:
    cmp word [DAP], READ_SECTORS_NUM
    jle _continue
    
    mov bx, disk_read_err
    call _print_string

_end:
    hlt
    jmp _end

%include "boot.stage1.print.asm"

DAP:
    db 0x10
    db 0
DAP_sectors_num:
    dw S1_READ_SECTORS_NUM
    dd (S1_BOOT_LOAD_ADDR + S1_SECTOR_SIZE)
    dq 1

boot_msg: db "Booting...", 0
disk_err_msg: db "Disk error!", 0
