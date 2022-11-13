    # -36[rbp] = r15
    # -40[rbp] = r14
    # -48[rbp] = r12
    .intel_syntax noprefix               # используем синтаксис intel
	.text
	.section	.rodata
.LC0:
	.string	"w"                          # открываем на запись
.LC1:
	.string	"output.txt"                 # используем файлик output.txt
	.text
	.globl	common_elements
	.type	common_elements, @function
common_elements:                         # common_elements()
	endbr64
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r14
	push	r12
	push	rbx
	sub	rsp, 80
	mov	QWORD PTR -88[rbp], rdi
	mov	QWORD PTR -96[rbp], rsi
	mov	rax, rsp
	mov	r12, rax
	mov	DWORD PTR r15, 0                  # int size = 0;
	mov	rax, QWORD PTR -88[rbp]
	mov	rdi, rax
	call	strlen@PLT                    # strlen(a)
	mov	rbx, rax
	mov	rax, QWORD PTR -96[rbp]
	mov	rdi, rax
	call	strlen@PLT                    # strlen(b)
	cmp	rbx, rax
	jnb	.L2                               # если условие не соблюдается, то переходим в .L2
	mov	rax, QWORD PTR -88[rbp]
	mov	rdi, rax
	call	strlen@PLT                   
	mov	DWORD PTR r15, eax                # условие соблюдается - size = strlen(a)
	jmp	.L3                               # условие соблюдено - переходим в .L3
.L2:
	mov	rax, QWORD PTR -96[rbp]
	mov	rdi, rax
	call	strlen@PLT                    # strlen(b)
	mov	DWORD PTR r15, eax                # size = strlen(b), условие не соблюдено
.L3:                                      
	mov	eax, DWORD PTR r15               # char answer[size];
	movsx	rdx, eax
	sub	rdx, 1
	mov	QWORD PTR -56[rbp], rdx
	movsx	rdx, eax
	mov	QWORD PTR -112[rbp], rdx
	mov	QWORD PTR -104[rbp], 0
	movsx	rdx, eax
	mov	r15, rdx
	mov r15, 0
	cdqe
	mov	edx, 16
	sub	rdx, 1
	add	rax, rdx
	mov	esi, 16
	mov	edx, 0
	div	rsi
	imul	rax, rax, 16
	mov	rcx, rax
	and	rcx, -4096
	mov	rdx, rsp
	sub	rdx, rcx
.L4:
	cmp	rsp, rdx
	je	.L5                          # идем в .L5
	sub	rsp, 4096
	or	QWORD PTR 4088[rsp], 0
	jmp	.L4                          # идем в .L4
.L5:
	mov	rdx, rax
	and	edx, 4095
	sub	rsp, rdx
	mov	rdx, rax
	and	edx, 4095
	test	rdx, rdx
	je	.L6                          # идем в .L6
	and	eax, 4095
	sub	rax, 8
	add	rax, rsp
	or	QWORD PTR [rax], 0
.L6:
	mov	rax, rsp
	add	rax, 0
	mov	QWORD PTR -64[rbp], rax
	mov	DWORD PTR r14, 0             # int count = 0
	mov	DWORD PTR -44[rbp], 0        # int i = 0
	jmp	.L7                          # идем в .L7
.L11:
	mov	DWORD PTR r12, 0        # int j = 0
	jmp	.L8                          # идем в .L8
.L10:
	mov	eax, DWORD PTR -44[rbp]      # if (a[i] == b[j])
	movsx	rdx, eax
	mov	rax, QWORD PTR -88[rbp]
	add	rax, rdx
	movzx	edx, BYTE PTR [rax]
	mov	eax, DWORD PTR r12
	movsx	rcx, eax
	mov	rax, QWORD PTR -96[rbp]
	add	rax, rcx
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	jne	.L9                          # условие не соблюдено - идем в .L9
	mov	eax, DWORD PTR -44[rbp]      # if (equals(answer, a[i]) == 5)
	movsx	rdx, eax
	mov	rax, QWORD PTR -88[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	edx, al
	mov	rax, QWORD PTR -64[rbp]
	mov	esi, edx
	mov	rdi, rax
	mov	eax, 0
	call	equals@PLT
	cmp	eax, 5
	jne	.L9                           # условие не соблюдено - идем в .L9
	mov	eax, DWORD PTR -44[rbp]       # answer[count] = a[i];
	movsx	rdx, eax
	mov	rax, QWORD PTR -88[rbp]
	add	rax, rdx
	movzx	ecx, BYTE PTR [rax]
	mov	rdx, QWORD PTR -64[rbp]
	mov	eax, DWORD PTR r14
	cdqe
	mov	BYTE PTR [rdx+rax], cl
	add	DWORD PTR r14, 1            # count++
.L9:
	add	DWORD PTR r12, 1       # ++j
.L8:
	mov	eax, DWORD PTR r12     # for (int j = 0; j < strlen(b); ++j)
	movsx	rbx, eax
	mov	rax, QWORD PTR -96[rbp]
	mov	rdi, rax
	call	strlen@PLT              # strlen(b)
	cmp	rbx, rax
	jb	.L10                        # условие соблюдено - идем в .L10
	add	DWORD PTR -44[rbp], 1
.L7:
	mov	eax, DWORD PTR -44[rbp]     # for (int j = 0; j < strlen(b); ++j)
	movsx	rbx, eax
	mov	rax, QWORD PTR -88[rbp]
	mov	rdi, rax
	call	strlen@PLT               # strlen(a)
	cmp	rbx, rax
	jb	.L11                         # условие соблюдено - идем в .L11
	lea	rax, .LC0[rip]               # output = fopen("output.txt", "w");
	mov	rsi, rax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	call	fopen@PLT                # fopen()
	mov	QWORD PTR -72[rbp], rax      # fprintf(output, "%s", answer);
	mov	rdx, QWORD PTR -72[rbp]
	mov	rax, QWORD PTR -64[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	fputs@PLT                # fputs()
	mov	rax, QWORD PTR -72[rbp]      # fclose(output);
	mov	rdi, rax
	call	fclose@PLT               # fclose()
	mov	rsp, r14
	nop
	lea	rsp, -32[rbp]
	pop	rbx
	pop	r12
	pop	r14
	pop	r15
	pop	rbp
	ret                              # return
	.size	common_elements, .-common_elements
