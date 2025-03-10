[org 0x7c00]

jmp main

startup_string: 
    db "booted kieran OS, ", 0

hello_world_string: 
    db "hello world.", 0

print:
    .loop:
        mov al, [bx]
        cmp al, 0
        je .done
        int 0x10
        inc bx
        jmp .loop
    .done:
        ret

main:
    mov bp, 0x8000 ; initialise the stack
    mov sp, bp

    mov ah, 0x0e ; enable bios teletype mode

    mov bx, startup_string
    call print

    mov bx, hello_world_string
    call print
    jmp $
    

times 510-($-$$) db 0
db 0x55, 0xaa
