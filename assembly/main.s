.intel_syntax noprefix        # используем синтаксис интел
  .text
  .globl  tv1
  .bss
  .align 16
  .type  tv1, @object
  .size  tv1, 16
tv1:
  .zero  16
  .globl  tv2
  .align 16
  .type  tv2, @object
  .size  tv2, 16
tv2:
  .zero  16
  .globl  dtv
  .align 16
  .type  dtv, @object
  .size  dtv, 16
dtv:
  .zero  16
  .globl  tz
  .align 8
  .type  tz, @object
  .size  tz, 8
tz:
  .zero  8
  .text
  .globl  time_start
  .type  time_start, @function
time_start:                        # void time_start() { gettimeofday(&tv1, &tz); }
  endbr64
  push  rbp
  mov  rbp, rsp
  lea  rax, tz[rip]
  mov  rsi, rax
  lea  rax, tv1[rip]
  mov  rdi, rax
  call  gettimeofday@PLT       # gettimeofday();
  nop
  pop  rbp
  ret
  .size  time_start, .-time_start
  .globl  time_stop
  .type  time_stop, @function
time_stop:                        # { gettimeofday(&tv2, &tz);
  endbr64
  push  rbp
  mov  rbp, rsp
  lea  rax, tz[rip]
  mov  rsi, rax
  lea  rax, tv2[rip]
  mov  rdi, rax
  call  gettimeofday@PLT      # gettimeofday();
  mov  rax, QWORD PTR tv2[rip]   # dtv.tv_sec= tv2.tv_sec -tv1.tv_sec;
  mov  rdx, QWORD PTR tv1[rip]
  sub  rax, rdx
  mov  QWORD PTR dtv[rip], rax
  mov  rax, QWORD PTR tv2[rip+8] # dtv.tv_usec=tv2.tv_usec-tv1.tv_usec;
  mov  rdx, QWORD PTR tv1[rip+8] 
  sub  rax, rdx
  mov  QWORD PTR dtv[rip+8], rax # if(dtv.tv_usec<0) { dtv.tv_sec--; dtv.tv_usec+=1000000; }
  mov  rax, QWORD PTR dtv[rip+8]
  test  rax, rax
  jns  .L3                       # .L3
  mov  rax, QWORD PTR dtv[rip]
  sub  rax, 1
  mov  QWORD PTR dtv[rip], rax
  mov  rax, QWORD PTR dtv[rip+8]
  add  rax, 1000000
  mov  QWORD PTR dtv[rip+8], rax
.L3:
  mov  rax, QWORD PTR dtv[rip]   # return dtv.tv_sec*1000+dtv.tv_usec/1000;
  imul  rsi, rax, 1000
  mov  rcx, QWORD PTR dtv[rip+8]
  movabs  rdx, 2361183241434822607
  mov  rax, rcx
  imul  rdx
  mov  rax, rdx
  sar  rax, 7
  sar  rcx, 63
  mov  rdx, rcx
  sub  rax, rdx
  add  rax, rsi
  pop  rbp
  ret
  .size  time_stop, .-time_stop
  .section  .rodata
.LC0:
  .string  "r"
.LC1:
  .string  "input1.txt"
.LC2:
  .string  "input2.txt"
.LC3:
  .string  "%d"
.LC4:
  .string  "Time: %ld \n"
  .text
  .globl  main
  .type  main, @function
main:                           # int main(int argc, char** argv) 
  endbr64
  push  rbp
  mov  rbp, rsp
  lea  r11, -16384[rsp]
.LPSRL0:
  sub  rsp, 4096
  or  DWORD PTR [rsp], 0
  cmp  rsp, r11
  jne  .LPSRL0
  sub  rsp, 3664
  mov  DWORD PTR -20036[rbp], edi
  mov  QWORD PTR -20048[rbp], rsi
  lea  rax, .LC0[rip]         # file1 = fopen("input1.txt", "r");
  mov  rsi, rax
  lea  rax, .LC1[rip]
  mov  rdi, rax
  call  fopen@PLT          # fopen()
  mov  QWORD PTR -8[rbp], rax # file1 = fopen("input2.txt", "r");
  lea  rax, .LC0[rip]
  mov  rsi, rax
  lea  rax, .LC2[rip]
  mov  rdi, rax
  call  fopen@PLT          # fopen()
  mov  QWORD PTR -16[rbp], rax
  mov  eax, 0
  call  time_start         # time_start();
  lea  rax, -24[rbp]          # scanf("%d", arg);
  mov  rsi, rax
  lea  rax, .LC3[rip]
  mov  rdi, rax
  mov  eax, 0
  call  __isoc99_scanf@PLT # scanf()
  mov  rax, QWORD PTR -24[rbp]# if (arg[0] == 1)
  cmp  rax, 1
  jne  .L6                    # .L6
  mov  eax, 0
  call  writing@PLT        # writing()
  jmp  .L7                    # .L7
.L6:
  mov  rax, QWORD PTR -24[rbp]
  cmp  rax, 2
  jne  .L8                    # .L8
  mov  eax, 0
  call  files@PLT          # files()
  jmp  .L7                    # .L7
.L8:
  mov  rax, QWORD PTR -24[rbp]
  cmp  rax, 3
  jne  .L9                    # .L9
  mov  eax, 0
  call  console@PLT        # console()
  jmp  .L7                    # .L7
.L9:
  mov  eax, 0                 # 0, который мы потом возвращаем
  jmp  .L11                   # .L11
  .L7:
    mov  rdx, QWORD PTR -8[rbp] # fgets(str1, 10000, file1);
    lea  rax, -10032[rbp]
    mov  esi, 10000
    mov  rdi, rax
    call  fgets@PLT             # fgets()
    mov  rdx, QWORD PTR -16[rbp]# fgets(str2, 10000, file2);
    lea  rax, -20032[rbp]
    mov  esi, 10000
    mov  rdi, rax
    call  fgets@PLT             # fgets()
	lea	rax, -10032[rbp]        # sort(str1);
	mov	rdi, rax
	call	sort@PLT            # sort()
	lea	rax, -10032[rbp]        # delete_repeats(str1);
	mov	rdi, rax
	call	delete_repeats@PLT # delete_repeats()
	lea	rax, -20032[rbp]       # sort(str2);
	mov	rdi, rax
	call	sort@PLT           # sort()
	lea	rax, -20032[rbp]       # delete_repeats(str2);
	mov	rdi, rax
	call	delete_repeats@PLT # delete_repeats()
	lea	rdx, -20032[rbp]       # common_elements(str1, str2);
	lea	rax, -10032[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	common_elements@PLT # common_elements();
	mov	eax, 0                  # common_elements(str1, str2);
	call	time_stop           # time_stop()
	mov	rsi, rax
	lea	rax, .LC4[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT           # printf()
	mov	eax, 0
.L11:
	leave
	ret
	.size	main, .-main
