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

; get num from eax
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

	mov rsi, newline
	mov rdx, nlen
	print rsi, rdx

	popd
%endmacro


section .text
global _start

_start:
	xor rax, rax
	mov rbx, 0
AVG:
	mov ecx, [array1 + rbx * 4]
	mov esi, [array2 + rbx * 4]
	
	sub ecx, esi
	js .neg
	jmp .pos
.neg:
    	neg ecx
.pos:
	add eax, ecx
	
	inc rbx

	cmp rbx, arrlen
	jne AVG

	cmp rbx, 0
	je .error

	cdq
	idiv rbx

	dprint

	mov rax, 60
	xor rdi, rdi
	syscall


.error:
	mov rax, 1
	mov rdi, 1
	print error, errorlen

	mov rax, 60
	xor rdi, rdi
	syscall

section .data
	array1 dd 5, 3, 2, 6, 1, 7, 4
	array2 dd 0, 10, 1, 9, 2, 8, 5
	arrlen equ ($ - array1) / 8

	error db 'Division by zero'
	errorlen equ $ - error
	
	done db 'Done'
	len equ $ - done
	newline db 0xA, 0xD
	nlen equ $ - newline


section .bss
	result resb 1

