; strlen - used to determine the length of a string
strlen:
    push ebx    ; Not sure why we do this in the context of this program
    mov ebx, eax    ; Copy the address of the message string from eax to ebxx

; nextchar - helper method which iterates over a null-terminated string, incrementing eax by one byte until the terminator is reached.
nextchar:
    cmp byte[eax], 0    ; Check if value stored at address stored in eax is 0
    jz finished         ; If it is (if the zero flag is set,) jump to finished
    inc eax             ; else increment eax
    jmp nextchar        ; jump back to the beginning of this function

; finished - used to store the length of the string in eax and return control flow to _start
finished:
    sub eax, ebx    ; subtract ebx from eax (which will result in the length of the string), and store it in eax
    pop ebx         ; restore the value of ebx (for some reason I still don't quite understand as we hadn't stored anything in ebx before entering this function.)
    ret             ; return control flow to the program

; exit - gracefully exit the program by calling sys_exit
exit:
    mov eax, 1  ; move syscall number for sys_exit into eax
    mov ebx, 0  ; move exit code for sys_exit into ebx, as required
    int 80h     ; call kernel
    ret

prints:
    ; Push registers to stack to preserve their values
    push edx    ; nothing of meaning here
    push ecx    ; nothing of meaning here
    push ebx    ; nothing of meaning here
    push eax    ; address of the message to be printed is in here, now pushed onto the stack
    call strlen

    ; now the length of the string is stored in eax
    mov edx, eax    ; Length of string is now loaded into edx, because we will need eax to store the syscall number for sys_write
    pop eax         ; Now the memory address of the helloworld message back in eax, restored by popping from the stack
    mov ecx, eax    ; Move that same address into ecx because we will need eax to store the syscall number for sys_write

    mov eax, 4      ; load syscall number for sys_write into eax
    mov ebx, 1      ; load file descriptor for STDOUT into ebx
    int 80h         ; call kernel

    ; Restore original values of registers
    pop ebx
    pop ecx
    pop edx
    ret