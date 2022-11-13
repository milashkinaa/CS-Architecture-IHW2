.intel_syntax noprefix           # используем синтакс интел
  .text
  .section  .rodata
.LC0:
  .string  "w"                      # открываем файл на запись
.LC1:
  .string  "input1.txt"             # открываем файл "input1.txt"  
.LC2:
  .string  "input2.txt"             # открываем файл "input2.txt"  
  .text
  .globl  writing
  .type  writing, @function
writing:                             # writing()
  endbr64
  push  rbp
  mov  rbp, rsp
  push  r15
  push  r14
  push  r13
  push  r12
  push  rbx
  sub  rsp, 104
  mov  rax, rsp
  mov  rbx, rax
  mov  edi, 0                      # srand(time(NULL));
  call  time@PLT
  mov  edi, eax
  call  srand@PLT               # srand()
  call  rand@PLT                # rand()
  movsx  rdx, eax                # int size1 = rand()%100;
  imul  rdx, rdx, 1374389535
  shr  rdx, 32
  sar  edx, 5
  mov  ecx, eax
  sar  ecx, 31
  sub  edx, ecx
  mov  DWORD PTR -60[rbp], edx
  mov  edx, DWORD PTR -60[rbp]
  imul  edx, edx, 100
  sub  eax, edx
  mov  DWORD PTR -60[rbp], eax
  call  rand@PLT                # rand()
  movsx  rdx, eax                # int size2 = rand()%100;
  imul  rdx, rdx, 1374389535
  shr  rdx, 32
  sar  edx, 5
  mov  ecx, eax
  sar  ecx, 31
  sub  edx, ecx
  mov  DWORD PTR -64[rbp], edx    # char mass1[size1];
  mov  edx, DWORD PTR -64[rbp]
  imul  edx, edx, 100
  sub  eax, edx
  mov  DWORD PTR -64[rbp], eax
  mov  eax, DWORD PTR -60[rbp]    
  movsx  rdx, eax
  sub  rdx, 1
  mov  QWORD PTR -72[rbp], rdx
  movsx  rdx, eax
  mov  QWORD PTR -128[rbp], rdx
  mov  QWORD PTR -120[rbp], 0
  movsx  rdx, eax
  mov  QWORD PTR -144[rbp], rdx
  mov  QWORD PTR -136[rbp], 0
  cdqe
  mov  edx, 16
  sub  rdx, 1
  add  rax, rdx
  mov  esi, 16
  mov  edx, 0
  div  rsi
  imul  rax, rax, 16
  mov  rcx, rax
  and  rcx, -4096
  mov  rdx, rsp                  
  sub  rdx, rcx
.L2:
  cmp  rsp, rdx
  je  .L3                         # .L3
  sub  rsp, 4096 
  or  QWORD PTR 4088[rsp], 0
  jmp  .L2                         # .L2
.L3:
  mov  rdx, rax
  and  edx, 4095
  sub  rsp, rdx
  mov  rdx, rax
  and  edx, 4095
  test  rdx, rdx
  je  .L4                         # .L4
  and  eax, 4095
  sub  rax, 8
  add  rax, rsp
  or  QWORD PTR [rax], 0
.L4:                                # char mass2[size2];
  mov  rax, rsp
  add  rax, 0
  mov  QWORD PTR -80[rbp], rax
  mov  eax, DWORD PTR -64[rbp]
  movsx  rdx, eax
  sub  rdx, 1
  mov  QWORD PTR -88[rbp], rdx
  movsx  rdx, eax
  mov  r14, rdx
  mov  r15d, 0
  movsx  rdx, eax
  mov  r12, rdx
  mov  r13d, 0
  cdqe
  mov  edx, 16
  sub  rdx, 1
  add  rax, rdx
  mov  esi, 16
  mov  edx, 0
  div  rsi
  imul  rax, rax, 16
  mov  rcx, rax
  and  rcx, -4096
  mov  rdx, rsp
  sub  rdx, rcx
.L5:
  cmp  rsp, rdx
  je  .L6                       # .L6
  sub  rsp, 4096
  or  QWORD PTR 4088[rsp], 0
  jmp  .L5                       # .L5
.L6:
  mov  rdx, rax
  and  edx, 4095
  sub  rsp, rdx
  mov  rdx, rax
  and  edx, 4095
  test  rdx, rdx
  je  .L7                       # .L7
  and  eax, 4095
  sub  rax, 8
  add  rax, rsp
  or  QWORD PTR [rax], 0
.L7:
  mov  rax, rsp
  add  rax, 0
  mov  QWORD PTR -96[rbp], rax
  mov  DWORD PTR -52[rbp], 0
  jmp  .L8                             # .L8
.L9:                                    # mass1[i] = rand()%56+'A';
  call  rand@PLT
  movsx  rdx, eax
  imul  rdx, rdx, -1840700269
  shr  rdx, 32
  add  edx, eax
  sar  edx, 5
  mov  ecx, eax
  sar  ecx, 31
  sub  edx, ecx
  imul  ecx, edx, 56
  sub  eax, ecx
  mov  edx, eax
  mov  eax, edx
  add  eax, 65
  mov  ecx, eax
  mov  rdx, QWORD PTR -80[rbp]
  mov  eax, DWORD PTR -52[rbp]
  cdqe
  mov  BYTE PTR [rdx+rax], cl
  add  DWORD PTR -52[rbp], 1
.L8:
  mov  eax, DWORD PTR -52[rbp]         # for (int i = 0; i < size1; ++i)
  cmp  eax, DWORD PTR -60[rbp]
  jl  .L9                             # .L9
  lea  rax, .LC0[rip]                  # file1 = fopen("input1.txt", "w");
  mov  rsi, rax
  lea  rax, .LC1[rip]
  mov  rdi, rax
  call  fopen@PLT                   # fopen()
  mov  QWORD PTR -104[rbp], rax
  mov  rdx, QWORD PTR -104[rbp]        # printf(file1, "%s", mass1);
mov  rax, QWORD PTR -80[rbp]
  mov  rsi, rdx
  mov  rdi, rax
  call  fputs@PLT
  mov  rax, QWORD PTR -104[rbp]        # fclose(file1);
  mov  rdi, rax
  call  fclose@PLT
  mov  DWORD PTR -56[rbp], 0           # for (int i = 0; i < size2; ++i)
  jmp  .L10                            # .L10
.L11:                                   # mass2[i] = rand()%56+'A';
  call  rand@PLT                    # rand()
  movsx  rdx, eax                    
  imul  rdx, rdx, -1840700269
  shr  rdx, 32
  add  edx, eax
  sar  edx, 5
  mov  ecx, eax
  sar  ecx, 31
  sub  edx, ecx
  imul  ecx, edx, 56
  sub  eax, ecx
  mov  edx, eax
  mov  eax, edx
  add  eax, 65
  mov  ecx, eax
  mov  rdx, QWORD PTR -96[rbp]
  mov  eax, DWORD PTR -56[rbp]
  cdqe
  mov  BYTE PTR [rdx+rax], cl
  add  DWORD PTR -56[rbp], 1
.L10:
  mov  eax, DWORD PTR -56[rbp]         # for (int i = 0; i < size2; ++i)
  cmp  eax, DWORD PTR -64[rbp]
  jl  .L11                            # .L11
  lea  rax, .LC0[rip]                  # file2 = fopen("input2.txt", "w");
  mov  rsi, rax
  lea  rax, .LC2[rip]
  mov  rdi, rax
  call  fopen@PLT                  # fopen()
  mov  QWORD PTR -112[rbp], rax
  mov  rdx, QWORD PTR -112[rbp]       # fprintf(file2, "%s", mass2);
  mov  rax, QWORD PTR -96[rbp]
  mov  rsi, rdx
  mov  rdi, rax
  call  fputs@PLT                  # fputs()
  mov  rax, QWORD PTR -112[rbp]       # fclose(file2);
  mov  rdi, rax
  call  fclose@PLT                 # fclose()
  mov  rsp, rbx
  nop
  lea  rsp, -40[rbp]
  pop  rbx
  pop  r12
  pop  r13
  pop  r14
  pop  r15
  pop  rbp
  ret                                # return
  .size  writing, .-writing
