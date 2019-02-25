%include '../lesson_5/functions.asm'

SECTION .data

helloworld_msg db 'This is our helloworld message. It will be printed using functions imported from another file', 0ah, 0h ; Note the null byte, used for termination
another_msg db 'We can print this too! Arent functions and external files great?', 0ah, 0h  ; Another null  byte
; h appended to a value (like the h in 0ah or 0h), tells the assembler to interpret the value as a hexidecimal value.

; Explanation:
; The reason that 'another_msg' printed twice is because in assembly variables are declared sequentially in memory. Our first call to
; prints printed 'helloworld_msg + another_msg' because it did not encounter a null byte which denotes the end of a string according to
; the strlen function we wrote. So it calculated the length of the string as being the length of helloworld_msg + the length of another_msg.
; It then received the address of 'another_msg' and calculated number of non-zero bytes after that address, which is the length of another_msg.

SECTION .text
global _start

_start:
    mov eax, helloworld_msg ; Move the address of helloworld_msg into eax, as required by strlen
    call prints

    mov eax, another_msg    ; The procedure is the same if we want to print another message
    call prints

    call exit
    ; note, our last message will print twice. We will fix this in the next lesson.