This is a simple example of a way to generate a valid multiboot binary
 using fasm in a single build step

The barrier to entry is a little bit lower than traditional examples
using nasm + ld because you do not need to cross compile LD
for generic elf first.


# prerequisites
I personally developed this in cygwin and the prereqs you will need
in your PATH:

- flat assembler, 'fasm'
- qemu binary dir, mainly 'qemu-system-i386'
- (optional) genisoimage for the iso version

getting this to build in windows proper should be as easy as converting
the shell scripts to .bats

# steps
just run 'br.sh' to do everyhting in one go and run in qemu right away.
note this uses the generated binary directly. If you want to see how to
generate a bootable ISO with your kernel in it, see 'br_iso.sh'
