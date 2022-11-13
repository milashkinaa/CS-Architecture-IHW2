	.intel_syntax noprefix                   # используем синтаксис интел
	.text
	.globl	delete_repeats
	.type	delete_repeats, @function
delete_repeats:                              # delete_repeats()
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR -24[rbp], rdi
	mov	rax, QWORD PTR -24[rbp]
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	mov	QWORD PTR -8[rbp], rax
	jmp	.L2                                  # идем в .L2
.L4:
	mov	rax, QWORD PTR -16[rbp]              # if(*p2 != *(p2 + 1))
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR -16[rbp]
	add	rax, 1
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	je	.L3                                  # идем в .L3
	add	QWORD PTR -8[rbp], 1                 # ++p1;
.L3:
	add	QWORD PTR -16[rbp], 1                # ++p2;
	mov	rax, QWORD PTR -16[rbp]
	movzx	edx, BYTE PTR [rax]
	mov	rax, QWORD PTR -8[rbp]
	mov	BYTE PTR [rax], dl
.L2:
	mov	rax, QWORD PTR -8[rbp]               # for (p1 = p2 = str; *p1; *p1 = *p2)
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L4                                  # условие не соблюдается - идем в .L4
	nop
	nop
	pop	rbp
	ret                                      # return
	.size	delete_repeats, .-delete_repeats
