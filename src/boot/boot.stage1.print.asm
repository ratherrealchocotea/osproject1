;; boot.stage1.print.asm

_print_string:
    pusha
    mov ah, 0x0e                ; Display character function

.print_string_loop:
    cmp byte [bx], 0
    je .print_string_end
    mov al, [bx]
    int 0x10                    ; BIOS video services
    
    inc bx
    jmp .print_string_loop

.print_string_end:
    popa
    ret
