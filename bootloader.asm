BITS 16

start:
	; Set up 4K stack after this bootloader
	; [Remember: Effective Address = Segment*16 + Offset]
	mov ax, 07C0h   ; Set 'ax' equal to the location of this bootloader divided by 16
	add ax, 20h     ; Skip over the size of the bootloader divided by 16
	mov ss, ax      ; Set 'ss' to this location (the beginning of our stack region)
	mov sp, 4096    ; Set 'ss:sp' to the top of our 4K stack

	; Set data segment to where we're loaded so we can implicitly access all 64K from here
	mov ax, 07C0h   ; Set 'ax' equal to the location of this bootloader divided by 16
	mov ds, ax      ; Set 'ds' to the this location

	; Print our message and stop execution
	mov si, message ; Put address of the null-terminated string to output into 'si'
	call print      ; Call our string-printing routine
	cli             ; Clear the Interrupt Flag (disable external interrupts)
	hlt             ; Halt the CPU (until the next external interrupt)


data:
	message db 'This was outputted by a basic bootloader!', 0


; Routine for outputting string in 'si' register to screen
print:
	mov ah, 0Eh     ; Specify 'int 10h' 'teletype output' function
	                ; [AL = Character, BH = Page Number, BL = Colour (in graphics mode)]
.printchar:
	lodsb           ; Load byte at address SI into AL, and increment SI
	cmp al, 0
	je .done        ; If the character is zero (NUL), stop writing the string
	int 10h         ; Otherwise, print the character via 'int 10h'
	jmp .printchar  ; Repeat for the next character
.done:
	ret


; Pad to 510 bytes (boot sector size minus 2) with 0s, and finish with the two-byte standard boot signature
times 510-($-$$) db 0 
dw 0xAA55	        ; => 0x55 0xAA (little endian byte order)