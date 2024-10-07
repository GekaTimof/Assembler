%macro print 2
	mov rax, 1
        mov rdi, 1
        mov rsi, %1
        mov rdx, %2
        syscall
%endmacro



section .text
global _start


_start:

	mov rax, [value]
	and rax, 1
	cmp rax, 0

	jne odd
	jmp even


odd:
	print message1, len1
	jmp end


even:
        print message2, len2
        jmp end


end:
	mov rax, 60
	xor rdi, rdi
	syscall


section .data
	value db 14

	message1 db 'Is odd', 0xA, 0xD
	len1 equ $ - message1
	message2 db 'Is even', 0xA, 0xD
        len2 equ $ - message2


