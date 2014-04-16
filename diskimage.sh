#!/bin/sh
nasm -f bin -o bootloader.bin bootloader.asm
dd conv=notrunc bs=512 count=1 if=bootloader.bin of=bootloader.flp
rm bootloader.bin
