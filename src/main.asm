section .data
    %define float64(x) __?float64?__(x)

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
    %define WIDTH_F         60.0
    %define HEIGHT_F        25.0
    %define ASPECT_RATIO    2.4

    ; Spheres owowowowowowowowowowowowowo
    SPHERES:
        ;  X   Y   Z   R  
        db 10, 10, 10, 5
        db 20, 20, 20, 5
        db 30, 30, 30, 5
        db 40, 40, 40, 5
        db 50, 50, 50, 5

    %define SPHERE_WIDTH      1 * 4  ; 1 byte per value, 4 values per sphere
    SPHERE_COUNT equ ($ - SPHERES) / (SPHERE_WIDTH)

    SPHERE_COLORS:
        dd FG_RED, FG_GREEN, FG_BLUE, FG_YELLOW, FG_MAGENTA
    %define SPH_X             0
    %define SPH_Y             4
    %define SPH_Z             8
    %define SPH_R             12
    %define SPHERE_NO         0

    %define BACKGROUND        FG_BLACK

    %define CAM_DIR_X      0
    %define CAM_DIR_Y      0
    %define CAM_DIR_Z      0

    SIN_CAM_DIR_X  dq 0.0
    SIN_CAM_DIR_Y  dq 0.0
    SIN_CAM_DIR_Z  dq 0.0
    COS_CAM_DIR_X  dq 1.0
    COS_CAM_DIR_Y  dq 1.0
    COS_CAM_DIR_Z  dq 1.0

    x       dq             0.0
    y       dq             0.0

    %define TWO         2.0
    %define ONE         1.0
    %define HALF        0.5
    %define NEG_ONE    -1.0

section .bss
    buffer resb COLOR_WIDTH 

section .text
global _start

%include "src/terminal.asm"
%include "src/raytrace.asm"

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
    ; call get_direction_x
    ; movsd xmm4, xmm0            ; Store X in xmm4
    ; call get_direction_y
    ; movsd xmm5, xmm0            ; Store Y in xmm5
    ; call get_direction_z
    ; movsd xmm2, xmm0            ; Store Z in xmm2
    ; movsd xmm1, xmm5            ; Move Y to xmm1
    ; movsd xmm0, xmm4            ; Move X to xmm0
    ; call  normalize
    mov rcx, 0
    call make_x

.bp:
    mov  rax, 60
    xor  rdi, rdi
    syscall

