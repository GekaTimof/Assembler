section .text
global _start


_start:

	mov rax, 5
	mov rbx, 6
	sub rax, rbx
	cmp rax, 0

	js negative

positive:
	mov rax, 1
	mov rdi, 1
	mov rsi, message2
	mov rdx, len2
	syscall
	jmp end

negative:
        mov rax, 1
        mov rdi, 1
        mov rsi, message1
        mov rdx, len1
        syscall

end:
	mov rax, 60
	xor rdi, rdi
	syscall


section .data
	message1 db 'Is negative', 0xA, 0xD
	len1 equ $ - message1
	message2 db 'Is positive', 0xA, 0xD
        len2 equ $ - message2


