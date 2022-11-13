	# -24[rbp] -> r12d
    # -20[rbp] -> r13d

    .intel_syntax noprefix          # используем синтаксис интел
	.text
	.globl	sort
	.type	sort, @function
sort:                               # void sort(char* str)
	endbr64
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 40
	mov	QWORD PTR -40[rbp], rdi
	mov	DWORD PTR r13d, 0           # for (int i = 0; i < strlen(str); ++i) 
	jmp	.L2                         # идем в .L2
.L6:
	mov	DWORD PTR r12d, 0           # for (int j = 0; j < strlen(str); ++j)
	jmp	.L3                         # идем в .L3
.L5:
	mov	eax, DWORD PTR r12d         # if (str[j] > str [i])
	movsx	rdx, eax
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	movzx	edx, BYTE PTR [rax]
	mov	eax, DWORD PTR r13d
	movsx	rcx, eax
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rcx
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	jle	.L4                        # возвращаемся в верхний цикл
	mov	eax, DWORD PTR r12d        # tmp = str[j];
	movsx	rdx, eax
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR -25[rbp], al
	mov	eax, DWORD PTR r13d        # str[j] = str[i];
	movsx	rdx, eax
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	mov	edx, DWORD PTR r12d
	movsx	rcx, edx
	mov	rdx, QWORD PTR -40[rbp]
	add	rdx, rcx
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR [rdx], al
	mov	eax, DWORD PTR r13d        # str[i] = tmp;
	movsx	rdx, eax
	mov	rax, QWORD PTR -40[rbp]
	add	rdx, rax
	movzx	eax, BYTE PTR -25[rbp]
	mov	BYTE PTR [rdx], al
.L4:
	add	DWORD PTR r12d, 1          #  ++j
.L3:
	mov	eax, DWORD PTR r12d        # j < strlen(str)
	movsx	rbx, eax
	mov	rax, QWORD PTR -40[rbp]
	mov	rdi, rax
	call	strlen@PLT             # strlen(str)
	cmp	rbx, rax
	jb	.L5                        # .L5  
	add	DWORD PTR r13d, 1
.L2:
	mov	eax, DWORD PTR r13d        # for (int i = 0; i < strlen(str); ++i)
	movsx	rbx, eax
	mov	rax, QWORD PTR -40[rbp]
	mov	rdi, rax
	call	strlen@PLT             # strlen(str)
	cmp	rbx, rax
	jb	.L6                        # .L6
	nop
	nop
	mov	rbx, QWORD PTR -8[rbp]
	leave
	ret                            # return
	.size	sort, .-sort
