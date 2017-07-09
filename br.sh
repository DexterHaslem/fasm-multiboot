fasm kernel.asm

# now run qemu right away on the ISO,
# this is a non-debug setup, it doesnt wait
qemu-system-i386 -kernel kernel.o
