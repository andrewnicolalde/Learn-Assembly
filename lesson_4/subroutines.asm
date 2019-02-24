; In this file, we will use subroutines to accomplish our goal.
SECTION .data
msg db 'Hello world! This is a long message which we will try to determine the length of with subroutines.', 0ah

SECTION .text
global _start

_start:
    mov eax, msg    ; Put the address of our message string into eax
    call strlen     ; Call our function

    mov edx, eax    ; Put the length of the string calculated in strlen into edx, as required by sys_write
    mov ecx, msg    ; Put the address of the string message into ECX, as required by sys_write
    mov ebx, 1      ; Put the file descriptor for STDOUT into ebx, as required by sys_write
    mov eax, 4      ; Put the opcode for sys_write into eax
    int 80h         ; Trigger an interrupt.

    ; Exit gracefully
    mov eax, 1      ; Put opcode for sys_exit into eax
    mov ebx, 0      ; Put exit code 0 into ebx
    int 80h         ; Trigger an interrupt.
    
strlen:             ; Our function declaration
    push ebx        ; Preserve the value in ebx by pushing it to the stack.
    mov ebx, eax    ; Copy the address of the message string from eax, where it is stored to ebx so that we can perform our pointer arithmetic.

nextchar:
    cmp byte [eax], 0   ; Check if the value stored at the address stored in eax is 0
    jz finished         ; If yes, jump to the "finished" label in the code.
                        ; jz = Jump if Zero
                        ; jz jumps to the specified point when the "zero flag" is set.
                        ; More info on the zero flag: https://en.wikipedia.org/wiki/Zero_flag
    inc eax             ; Else (if zero flat is NOT set), increment eax by one byte
    jmp nextchar         ; Jump to the "nextchar" label in the code, effectively a loop.

finished:
    sub eax, ebx    ; Subtract ebx from eax and store the result in eax.
    pop ebx         ; Pop the original value of ebx from the stack and back into ebx.
    ret             ; Return to the calling function.