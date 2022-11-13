	# -20[rbp] -> r12d

    .intel_syntax noprefix               # используем синтаксис интел
	.text
	.globl	equals
	.type	equals, @function
equals:                                  # equals()
	endbr64
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 40
	mov	QWORD PTR -40[rbp], rdi
	mov	eax, esi
	mov	BYTE PTR -44[rbp], al
	cmp	QWORD PTR -40[rbp], 0          # if (a == NULL)
	jne	.L2                            # условие не соблюдается - идем в .L2
	mov	eax, 5                         # 5, которую при соблюдении возвращаем
	jmp	.L3                            # условие соблюдается - идем в .L3
.L2:
	mov	DWORD PTR r12d, 0              # for (int i = 0; i < strlen(a); i++)
	jmp	.L4                            # условие соблюдается - идем в .L4
.L6:
	mov	eax, DWORD PTR r12d           # if (a[i] == elem)
	movsx	rdx, eax
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	cmp	BYTE PTR -44[rbp], al
	jne	.L5                            # условие не соблюдается - идем в .L5
	mov	eax, 1
	jmp	.L3                            # условие соблюдается - идем в .L3
.L5:
	add	DWORD PTR r12d, 1              # i++
.L4:
	mov	eax, DWORD PTR r12d          # i < strlen(a)
	movsx	rbx, eax
	mov	rax, QWORD PTR -40[rbp]
	mov	rdi, rax
	call	strlen@PLT                 # strlen(a)
	cmp	rbx, rax
	jb	.L6                            # .L6
	mov	eax, 5                         # 5, которую при соблюдении возвращаем
.L3:
	mov	rbx, QWORD PTR -8[rbp]
	leave
	ret                                # return
	.size	equals, .-equals
