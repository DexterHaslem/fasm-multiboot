fasm kernel.asm

mkdir -p iso
mkdir -p iso/boot
mkdir -p iso/boot/grub

cp kernel.o iso/boot/fmb.k
cp stage2_eltorito iso/boot/grub
cat > iso/boot/grub/menu.lst << EOF
default 0
timeout 1
title fasm multiboot
kernel /boot/fmb.k
EOF

genisoimage -R -b boot/grub/stage2_eltorito -no-emul-boot -boot-load-size 4 \
	-boot-info-table -o fmb.iso iso

# now run qemu right away on the ISO,
# this is a non-debug setup, it doesnt wait
qemu-system-i386 -cdrom fmb.iso
