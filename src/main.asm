section .data
    %define ESCAPE           27
    %define FG_BLACK         "[30m"
    %define FG_RED           "[31m"
    %define FG_GREEN         "[32m"
    %define FG_YELLOW        "[33m"
    %define FG_BLUE          "[34m"
    %define FG_MAGENTA       "[35m"
    %define FG_CYAN          "[36m"
    %define FG_WHITE         "[37m"
    %define RESET            "[0m"

    %define CHARACTER        "█"

    %define CHAR_LENGTH      3
    %define COLOR_WIDTH      5
    %define WIDTH           60 
    %define HEIGHT          25

    ; Spheres owowowowowowowowowowowowowo
    SPHERES:
        ;  X   Y   Z   R  
        db 10, 10, 10, 5
        db 20, 20, 20, 5
        db 30, 30, 30, 5
        db 40, 40, 40, 5
        db 50, 50, 50, 5
    SPHERE_COLORS:
        dd FG_RED, FG_GREEN, FG_BLUE, FG_YELLOW, FG_MAGENTA
    %define SPH_X             0
    %define SPH_Y             4
    %define SPH_Z             8
    %define SPH_R             12
    %define SPHERE_WIDTH      1 * 4
    %define SPHERE_NO         1

    %define BACKGROUND        FG_BLACK

section .bss
    buffer resb COLOR_WIDTH 

section .text
global _start

%include "src/terminal.asm"

_start:
    mov  rsi, buffer
    mov  rdx, COLOR_WIDTH

    lea  r10, [SPHERE_COLORS + SPHERE_NO * 4]

loop:
    push rsi
    mov  rsi, r10 
    dec  rsi
    mov  byte [rsi], ESCAPE

    inc  rcx
    cmp  rcx, WIDTH
    jne  .normal

    call print_char
    call printlf
    mov  rcx, 0
    pop  rsi

    inc  r9
    cmp  r9, HEIGHT
    jne  loop
    jmp done

    .normal:
        push rcx
        call print_char
        pop  rcx
        pop  rsi
        jmp  loop
    
done:
    mov  rax, 60
    xor  rdi, rdi

    syscall
