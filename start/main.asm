section .text
global _start


_start:
	mov rax, 1
	mov rdi, 1
	mov rsi, message
	mov rdx, 6
	syscall

	mov rax, 60
	xor rdi, rdi
	syscall


section .data
	message db 'test', 0xA, 0xD



