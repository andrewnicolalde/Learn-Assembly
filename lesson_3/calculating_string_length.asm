SECTION .data
msg db 'Hello brave new world! Here are some more characters. And maybe some more. Does it really matter?', 0ah    ; Longer string this time

SECTION .text
global _start

_start:
    mov ebx, msg    ; Move the address of our message into EBX
    mov eax, ebx    ; Move the contents of EBX (which is the address of the message string) into EAX
                    ; We are going to move EAX forward by one byte until we reach the end of the string.

nextchar:
    cmp byte [eax], 0   ; Compare byte pointed to by eax with 0. 0 is an end of string delimiter.
    jz finished         ; If byte at the address stored in EAX is 0, jump to finished. 
    inc eax             ; Else, increment the address at EAX by one byte.
    jmp nextchar        ; Jump back to the point in the code labeled nextchar and compare again. This is a loop.

finished:
    sub eax, ebx        ; Subtract the address at EBX from EAX. Remember that we have been incrementing EAX, so it will always be larger.
                        ; When you subtract two memory addresses of the same type from one another, the result is the number of segments
                        ; between them, which is stored in EAX
    mov edx, eax        ; Copy the calculated length of the string from EAX into EDX, as is necessary for sys_write
    mov ecx, msg        ; Put the address of msg into ecx, as is necessary for sys_write
    mov ebx, 1          ; Put the file descriptor for STDOUT into ebx, as is necessary for sys_write
    mov eax, 4          ; Write the opcode for sys_write into EAX
    int 80h             ; Trigger an interrupt.

    mov ebx, 0  ; Set exit status code to 0
    mov eax, 1  ; Set opcode for sys_exit
    int 80h     ; Trigger an interrupt.