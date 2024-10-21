    org 0x7c00
    bits 16

    mov bp, 0x5000
    mov sp, bp
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov bx, 0x7e00
    mov [diskNum], dl

main:
    mov ah, 2
    mov al, 1
    push ax
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, [diskNum]

    int 0x13

priting:
    jc ERROR
    pop cx
    cmp al, cl
    jne ERROR_READING
    mov ah, 0x0e
    mov al, [0x7e00]
    int 0x10
    jmp $

ERROR:
    mov bx, ERROR_MESSAGE
ERROR2:
    mov ah, 0x0e
    mov al, byte [bx]
    int 0x10
    inc bx
    cmp al, 0
    je ERROR_ENDING
    jmp ERROR2



ERROR_READING:
    mov ah, 0x0ea
    int 0x10
    mov ah, 0x0e
    mov al, ' '
    int 0x10
    mov bx, ERROR_MESSAGE2
ERROR_READING2:
    mov ah, 0x0e
    mov al, byte [bx]
    int 0x10
    inc bx
    cmp al, 0
    je ERROR_ENDING
    jmp ERROR_READING2

ERROR_ENDING:
    jmp $

diskNum:
    db 0
ERROR_MESSAGE:
    db "ERROR LOADING DISK", 0
ERROR_MESSAGE2:
    db "ERROR READING SECTOR", 0

    times 510-($-$$) db 0
    dw 0AA55h

    times 512 db 'A'

