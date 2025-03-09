[org 0x7c00]

jmp _boot_start

startup_msg: db "booted kieran OS, hello world", 0
msg2: db "what the sigma", 0
buffer: times 10 db 0

ILOD: jmp $ ; infinite loop of death

print:
    mov al, [bx]
    cmp al, 0
    je done
    int 0x10
    inc bx
    jmp print
    

_boot_start:
    mov ah, 0x0e
    mov bx, startup_msg
    jmp print
done:
    jmp ILOD
    

times 510-($-$$) db 0
db 0x55, 0xaa