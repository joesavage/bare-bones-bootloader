SOURCE = bootloader.nasm
BINARY = bootloader.bin

VM = qemu-system-i386
VMARGS = -fda ${BINARY} -curses

AS = yasm
ASFLAGS = -fbin
ifeq (${SOURCE}, bootloader.S)
	ASFLAGS += -pgas
endif

virtual_machine: ${BINARY}
	${VM} ${VMARGS}

${BINARY}: ${SOURCE}
	${AS} ${ASFLAGS} $< -o $@

clean:
	${RM} ${BINARY}

.PHONY: virtual_machine clean
