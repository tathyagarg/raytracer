print:
  mov  rax, 1
  mov  rdi, 1
  syscall
  ret

printlf:
  push rdx
  mov  rsi, 0ah
  mov  rdx, 1
  push rsi

  mov  rsi, rsp
  call print
  pop  rsi
  pop  rdx
  ret

print_char:
  push rdx
  call print
  mov  rsi, CHARACTER
  mov  rdx, CHAR_LENGTH
  push rsi

  mov  rsi, rsp
  call print
  pop  rsi
  pop  rdx
  ret
