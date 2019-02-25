%include 'functions.asm'

SECTION .data

helloworld_msg db 'This is our helloworld message. It will be printed using functions imported from another file', 0ah
another_msg db 'We can print this too! Arent functions and external files great?', 0ah

SECTION .text
global _start

_start:
    mov eax, helloworld_msg ; Move the address of helloworld_msg into eax, as required by strlen
    call prints

    mov eax, another_msg    ; The procedure is the same if we want to print another message
    call prints

    call exit
    ; note, our last message will print twice. We will fix this in the next lesson.