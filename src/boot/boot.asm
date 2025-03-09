[org 0x7c00]

jmp main

startup_msg: db "booted kieran OS, hello world", 0

death_loop: 
    jmp $ ; infinite loop of death

print:
    mov al, [bx]
    cmp al, 0
    je break
    int 0x10
    inc bx
    jmp print
    
main:
    ; initialise the stack
    mov bp, 0x8000
    mov sp, bp

    ; enable bios teletype mode
    mov ah, 0x0e

    ; push '!' on the stack
    mov bl, '!'
    push bx

    mov bx, startup_msg
    jmp print
break:
    ; pop '!' off the stack into ax, and print it 
    pop ax
    int 0x10

    jmp death_loop
    
times 510-($-$$) db 0
db 0x55, 0xaa
