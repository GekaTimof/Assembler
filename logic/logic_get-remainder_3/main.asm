%macro pushd 0
	push rax
	push rbx
	push rcx
	push rdx
%endmacro


%macro popd 0
	pop rdx
        pop rcx
        pop rbx
        pop rax
%endmacro


%macro print 2
	mov rax, 1
        mov rdi, 1
        mov rsi, %1
        mov rdx, %2
        syscall
%endmacro


%macro dprint 0
	pushd
	mov rbx, 0
	mov rcx, 10
	%%divide:
	        xor rdx, rdx
	        div rcx
	        push rdx
	        inc rbx
	        cmp rax, 0
	        jne %%divide

	%%digit:
        	pop rax
        	add rax, '0'
		mov [result], rax
		print result, 1
		dec rbx
		cmp rbx, 0
		jg %%digit

	popd
%endmacro



section .text
global _start

_start:
	xor rax, rax
	xor rbx, 0
sum:
	mov al, [array + rbx]
        dprint
	inc rbx

	cmp rbx, arrlen
	jne sum
	dprint



	print newline, nlen
	print done, len
	print newline, nlen
	mov rax, 60
	xor rdi, rdi
	syscall



section .data
	array db 10, 13, 14, 7, 8, 12
	arrlen equ $ - array

	done db 'Done'
	len equ $ - done
	newline db 0xA, 0xD
	nlen equ $ - newline


section .bss
	result resb 1

