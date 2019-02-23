; If we want the program to exit correctly, we must call sys_exit, which happens to be opcode 1

; Everything is the same as before
SECTION .data
msg db 'Hello world!', 0ah   ; assign message varibale with the string that is our message, 0ah is linefeed

SECTION .text
global _start   ; Apparently this denotes the entrypoint for our program.

_start:
    mov edx, 13  ; For sys_write, EDX must be loaded with the length in bytes of the message to write.
    mov ecx, msg    ; For sys_write, ECX is loaded with the memory address of our message string.
    mov ebx, 1      ; For sys_write, EBX is loaded with the file descriptor for the file we want to write to, in this case STDOUT
    mov eax, 4      ; After a software interrupt, the kernel will invoke whatever function is denoted by the opcode we load into EAX
                    ; In this case, the function denoted by opcode 4 is sys_write, though some online sources seem to contradict this.
    int 80h         ; Call the kernel, telling it to execute the function denoted by the opcode loaded into EAX.

    ; Everything above is the same as in lesson 1, everything below is the code that will make the program exit gracefully.

    mov ebx, 0  ; For sys_exit, the value of ebx is the exit status code.
    mov eax, 1  ; Load the opcode for sys_exit into EAX, from which the kernel will read.
    int 80h     ; Recall that int means interrupt, NOT integer.