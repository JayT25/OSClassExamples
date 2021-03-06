[org 0x7c00]

START:

mov [BOOT_DRIVE], dl

mov bp, 0x8000
mov sp, bp

mov ah, 0x00                ; resetting disk 
int 0x13 


; pass arguments
mov ah, 0x02                ; int 13h function 02
mov al, 0x02                ; read 2 sectors
push ax

mov ch, 0x00                ; cylinder no.
mov cl, 0x02                ; sector no. (sector 1 is boot sector)
push cx

mov dh, 0x00                ; head no.
mov dl, [BOOT_DRIVE]        ; drive no.
push dx

mov bx, 0x0000              ; read disk data to es:bx
mov es, bx 
push es
mov bx, 0x9000  
push bx

call read_disk              ; read disk data

mov bx, READ_DISK
call print_msg
call print_line

mov cl, [0x9000] 
call print_byte
call print_space

mov cl, [0x9001] 
call print_byte
call print_space

mov cl, [0x9002] 
call print_byte
call print_space

mov cl, [0x9003] 
call print_byte
call print_space

mov bx, 0x0000 
mov es, bx 
push es
mov bx, 0x9000  
push bx
retf


%include "read_disk.asm"
%include "print_byte.asm"
%include "print_mem.asm"
%include "print_msg.asm"
%include "print_space.asm"
%include "print_line.asm"


BOOT_DRIVE:
    db 0

READ_DISK:
    db "Read new program from disk sectors.", 0

times 510 -($-$$) db 0
dw 0xaa55

main:

    mov ah, 0x0e
    mov al, 0x0d
    int 0x10

    mov ah, 0x0e
    mov al, 0x0a
    int 0x10

    mov ah, 0x0e 
    mov al, 'S'
    int 0x10

    mov ah, 0x0e 
    mov al, 't'
    int 0x10

    mov ah, 0x0e 
    mov al, 'a'
    int 0x10

    mov ah, 0x0e 
    mov al, 'r'
    int 0x10

    mov ah, 0x0e 
    mov al, 't'
    int 0x10

    mov ah, 0x0e 
    mov al, 'e'
    int 0x10

    mov ah, 0x0e 
    mov al, 'd'
    int 0x10

    mov ah, 0x0e 
    mov al, ' '
    int 0x10

    mov ah, 0x0e 
    mov al, 'n'
    int 0x10

    mov ah, 0x0e 
    mov al, 'e'
    int 0x10
 
    mov ah, 0x0e 
    mov al, 'w'
    int 0x10

    mov ah, 0x0e 
    mov al, ' '
    int 0x10

    mov ah, 0x0e 
    mov al, 'p'
    int 0x10

    mov ah, 0x0e 
    mov al, 'r'
    int 0x10

    mov ah, 0x0e 
    mov al, 'o'
    int 0x10

    mov ah, 0x0e 
    mov al, 'g'
    int 0x10
 
    mov ah, 0x0e 
    mov al, 'r'
    int 0x10

    mov ah, 0x0e 
    mov al, 'a'
    int 0x10

    mov ah, 0x0e 
    mov al, 'm'
    int 0x10

    mov ah, 0x0e 
    mov al, '.'
    int 0x10

    jmp $

ANNOUNCEMENT:
    db "New program starts...", 0

times 1024-($-$$) db 0
times 512 db 0
