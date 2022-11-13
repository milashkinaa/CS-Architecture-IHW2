	.intel_syntax noprefix                 # используем синтаксис интел
	.text
	.section	.rodata
.LC0:
	.string	"w"                            # открываем файл на запись  
.LC1: 
	.string	"input1.txt"                   # используем файлик input1.txt
.LC2:
	.string	"input2.txt"                   # используем файлик input2.txt
	.text
	.globl	console
	.type	console, @function
console:                                   # console()
	endbr64
	push	rbp
	mov	rbp, rsp
	lea	r11, -16384[rsp]
.LPSRL0:
	sub	rsp, 4096
	or	DWORD PTR [rsp], 0
	cmp	rsp, r11
	jne	.LPSRL0
	sub	rsp, 3648
	lea	rax, .LC0[rip]              # fopen("input1.txt", "w");
	mov	rsi, rax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	call	fopen@PLT               # fopen()
	mov	QWORD PTR -16[rbp], rax
	lea	rax, .LC0[rip]              # fopen("input2.txt", "w");
	mov	rsi, rax
	lea	rax, .LC2[rip]
	mov	rdi, rax
	call	fopen@PLT               # fopen()
	mov	QWORD PTR -24[rbp], rax
	mov	DWORD PTR -4[rbp], 0        # int n1 = 0;
	mov	DWORD PTR -8[rbp], 0        # int n2 = 0;
	jmp	.L2                         # идем в .L2
.L3:
	mov	eax, DWORD PTR -4[rbp]      # ch1[n1] = c;
	cdqe
	movzx	edx, BYTE PTR -25[rbp]
	mov	BYTE PTR -10032[rbp+rax], dl
	add	DWORD PTR -4[rbp], 1        # n1 += 1;
.L2:
	mov	rax, QWORD PTR stdin[rip]   # while ((c = fgetc(stdin)) != EOF)
	mov	rdi, rax
	call	fgetc@PLT
	mov	BYTE PTR -25[rbp], al
	cmp	BYTE PTR -25[rbp], -1
	jne	.L3                         # условие не выполняется - идем в .L3
	jmp	.L4                         # условие выполняется - идем в .L4
.L5:
	mov	eax, DWORD PTR -8[rbp]      # ch2[n2] = c;
	cdqe
	movzx	edx, BYTE PTR -25[rbp]
	mov	BYTE PTR -20032[rbp+rax], dl
	add	DWORD PTR -8[rbp], 1        # n2 += 1;
.L4:
	mov	rax, QWORD PTR stdin[rip]   # while ((c = fgetc(stdin)) != EOF)
	mov	rdi, rax
	call	fgetc@PLT
	mov	BYTE PTR -25[rbp], al
	cmp	BYTE PTR -25[rbp], -1
	jne	.L5                         # условие выполняется - идем в .L5  
	mov	rdx, QWORD PTR -16[rbp]     # fprintf(file1, "%s", ch1);
	lea	rax, -10032[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	fputs@PLT               # fprintf()
	mov	rdx, QWORD PTR -24[rbp]     # fprintf(file2, "%s", ch2);
	lea	rax, -20032[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	fputs@PLT               # fprintf()
	nop
	leave
	ret                             # return
	.size	console, .-console
