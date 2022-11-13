	.intel_syntax noprefix              # используем синтакс интел
	.text
	.section	.rodata
.LC0:
	.string	"r"                         # открываем файлы на чтение
.LC1:
	.string	"input1.txt"                # используем input1.txt               
.LC2:
	.string	"input2.txt"                # используем input2.txt  
	.text
	.globl	files
	.type	files, @function
files:                                  # files()
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	lea	rax, .LC0[rip]                  # file1 = fopen("input1.txt", "r");
	mov	rsi, rax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	call	fopen@PLT                   # fopen("input1.txt", "r")
	mov	QWORD PTR -8[rbp], rax
	lea	rax, .LC0[rip]                  # file1 = fopen("input2.txt", "r");
	mov	rsi, rax
	lea	rax, .LC2[rip]
	mov	rdi, rax
	call	fopen@PLT                   # fopen("input2.txt", "r")
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -8[rbp]          # fclose(file1);
	mov	rdi, rax
	call	fclose@PLT                  # fclose()
	mov	rax, QWORD PTR -16[rbp]         # fclose(file2);
	mov	rdi, rax
	call	fclose@PLT                  # fclose()
	nop
	leave
	ret                                 # return
	.size	files, .-files
