A really basic BIOS 'bootloader' (sort of - it doesn't actually load
any external code, but it boots for sure and could load with minor
additions).  Keepin' it real-mode, homies.

To compile the nasm version and run the resulting binary in qemu:

```sh

    make

```

If you only want to compile the binary:

```sh

    make bootloader.bin

```

For the AT&T-Style version set SOURCE to "bootloader.S":

```sh

    make SOURCE=bootloader.S bootloader.bin

```

Associated [Blog Post](http://www.reinterpretcast.com/creating-a-bare-bones-bootloader)
