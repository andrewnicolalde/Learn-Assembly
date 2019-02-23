;This is a hello world for NASM assembly!
;Please forgive me if any of the terminology is wrong here, somewhat new to this world
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
    ; This program will exit by segfaulting!