; fasm multiboot example
; this shows how to use elf (or bin if you want)
; fasm output with a multiboot header with grub

format elf ; you can use elf or binary with mb kludge
org 0x100000
use32

_start:
; this is the multiboot header
mbflags=0x03 or (1 shl 16)
dd 0x1BADB002
dd mbflags   ; 4k alignment, provide meminfo
dd -0x1BADB002-mbflags	; mb checksum
	dd _start		; header_addr
	dd _start		; load_addr
	dd _end_data	; load_end_addr
	dd _end 		; bss_end_addr
	dd _kstart 		; entry point
; end mb header

; code
_kstart:
	; set stack right away
	mov esp, _kstack

	; grub sets up 80x25 mode for us
	mov edi, 0xB8000 ; video memory

	; the screen data is left as is, showing
	; qemu boot messages and crap, so clear it out

	; since we dont care about the actual
	; rows and heights we can just linearly nuke the total
	; num of bytes:
	; 80x25 = 2000 chars,
	; each visible char has a value byte and display control byte
	; so total bytes = 2000 * 2, 4000 bytes
	; however we can simplify this by setting a full 32 bits each
	; loop (4 bytes or 2 chars)
	mov ecx, 1000
	cld
	@@:
		; set 1F control bytes, 0x00 text bytes
		mov dword [edi + ecx * 4], 0x1F001F00
	loop @b

	; now display a message before halting
	mov esi,msg
	mov ecx,msglen
	@@:
		lodsb
		stosb
		mov byte [edi], 0x1F
		inc edi
	loop @b

	hlt

; data section
msg db 'hello from a multiboot elf'
msglen = $ - msg

_end_data:

; bss uninit data here


; reserve the number of bytes of how big you want the kernel stack to be
rb 16384
_kstack:


_end:
