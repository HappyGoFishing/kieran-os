[org 0x7c00]

jmp main

gdt_start:

startup_message_string: 
    db "Kieran OS Bootloader (16bit Real Mode) ", 0

print:
    mov al, [bx]
    cmp al, 0
    je .exit_loop
    int 0x10
    inc bx
    jmp print

    .exit_loop:
        ret
        

main:
    mov bp, 0x8000 ; initialise the stack
    mov sp, bp

    mov ah, 0x0e ; enable bios teletype mode

    mov bx, startup_message_string
    call print
    
rw_loop: ; repeatedly read characters and write them out
    mov ah, 0x00
    int 0x16
    mov ah, 0x0e
    int 0x10
    jmp rw_loop

    jmp $
    
times 510-($-$$) db 0
db 0x55, 0xaa ; tell bios that this sector is bootable
