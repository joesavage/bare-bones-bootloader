	.code16

_start:
    mov $0x07C0, %ax
    add $0x20, %ax
    mov %ax, %ss /* move 0x7E0 to %ss */

    mov $4096, %sp

    mov $0x07C0, %ax
    mov %ax, %ds

    mov $message, %si
    call print

    cli
    hlt

data:
message:
    .asciz "This was outputted by a basic bootloader!"

print:
    mov $0x0E, %ah
    /* /teletype output function/ for /int 10h/ */

printchar:
    lodsb
    cmp $0, %al
    je done
    int $0x10
    jmp printchar
done:
    ret

    .space 510-(.-_start), 0
    .word 0xAA55

