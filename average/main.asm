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

; get num from rax
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

%%print_digits:
    dec rbx                    
    pop rax                    
    add rax, '0'               
    mov [result], al          
    print result, 1            
    cmp rbx, 0
    jg %%print_digits          

    
    mov rsi, newline           
    mov rdx, nlen             
    print rsi, rdx            

    popd
%endmacro

section .text
global _start

_start:
    xor rax, rax               
    xor rbx, rbx               

AVG:
    mov ecx, [array1 + rbx * 4] 
    mov edx, [array2 + rbx * 4]  
    
    sub ecx, edx               
    add rax, rcx              
    
    dprint
    
    inc rbx                     
    cmp rbx, arrlen             
    jl AVG                      


    mov ecx, arrlen          
    xor rdx, rdx  
    
    test rax, rax
    jge .positive
          
    neg rax
      
      
.positive:          
    cdq                         
    idiv ecx  
    
                
    dprint                      

    mov rax, 60                 
    xor rdi, rdi                
    syscall

section .data
    array1 dd 5, 3, 2, 6, 1, 7, 4 
    array2 dd 0, 10, 1, 9, 2, 8, 5
    arrlen equ ($ - array1) / 8

    newline db 0xA                
    nlen equ $ - newline           

section .bss
    result resb 10                
                   

