	.file	"console.c"
	.intel_syntax noprefix
	.text
	.globl	mygetch
	.type	mygetch, @function
mygetch:                          # int mygetch()
	endbr64
	push	rbp
	mov	rbp, rsp
	add	rsp, -128
	lea	rax, -64[rbp]             # tcgetattr( STDIN_FILENO, &oldt );
	mov	rsi, rax
	mov	edi, 0
	call	tcgetattr@PLT         # tcgetattr();
	mov	rax, QWORD PTR -64[rbp]   # newt = oldt;
	mov	rdx, QWORD PTR -56[rbp]
	mov	QWORD PTR -128[rbp], rax
	mov	QWORD PTR -120[rbp], rdx
	mov	rax, QWORD PTR -48[rbp]
	mov	rdx, QWORD PTR -40[rbp]
	mov	QWORD PTR -112[rbp], rax
	mov	QWORD PTR -104[rbp], rdx
	mov	rax, QWORD PTR -32[rbp]
	mov	rdx, QWORD PTR -24[rbp]
	mov	QWORD PTR -96[rbp], rax
	mov	QWORD PTR -88[rbp], rdx
	mov	rax, QWORD PTR -16[rbp]
	mov	QWORD PTR -80[rbp], rax
	mov	eax, DWORD PTR -8[rbp]
	mov	DWORD PTR -72[rbp], eax
	mov	eax, DWORD PTR -116[rbp]  # newt.c_lflag &= ~( ICANON | ECHO );
	and	eax, -11
	mov	DWORD PTR -116[rbp], eax
	lea	rax, -128[rbp]            # tcsetattr( STDIN_FILENO, TCSANOW, &newt );
	mov	rdx, rax
	mov	esi, 0
	mov	edi, 0
	call	tcsetattr@PLT         # tscetattr()
	call	getchar@PLT           # ch = getchar();
	mov	DWORD PTR -4[rbp], eax
	lea	rax, -64[rbp]
	mov	rdx, rax                  # tcsetattr( STDIN_FILENO, TCSANOW, &oldt );
	mov	esi, 0
	mov	edi, 0
	call	tcsetattr@PLT         # tcsetattr()
	mov	eax, DWORD PTR -4[rbp]
	leave
	ret                           # return ch;
	.size	mygetch, .-mygetch
	.globl	get_string
	.type	get_string, @function
get_string:                       # char* get_string(char* str)
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	DWORD PTR -4[rbp], 0      # int i = 0;
.L4:
	mov	eax, 0                    # ch = mygetch();
	call	mygetch               # mygetch()
	mov	DWORD PTR -8[rbp], eax
	mov	rdx, QWORD PTR stdout[rip] # putc(ch, stdout); 
	mov	eax, DWORD PTR -8[rbp]
	mov	rsi, rdx
	mov	edi, eax
	call	putc@PLT               # putc()
	mov	eax, DWORD PTR -4[rbp]     # str[i++] = ch;
	lea	edx, 1[rax]
	mov	DWORD PTR -4[rbp], edx
	movsx	rdx, eax
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	edx, DWORD PTR -8[rbp]
	mov	BYTE PTR [rax], dl        # ch != 4
	cmp	DWORD PTR -8[rbp], 4      # return &str[i+1];
	jne	.L4                       # .L4
	mov	eax, DWORD PTR -4[rbp]    # str[i] = '\0';
	movsx	rdx, eax
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	BYTE PTR [rax], 0
	mov	eax, DWORD PTR -4[rbp]    # return &str[i+1];
	cdqe
	lea	rdx, 1[rax]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	leave 
	ret                           # return
	.size	get_string, .-get_string
	.section	.rodata
.LC0:
	.string	"w"                   # открываем файлы на запись
.LC1:
	.string	"input1.txt"          # input1.txt
.LC2:
	.string	"input2.txt"          # input2.txt
	.text
	.globl	console
	.type	console, @function
console:                          # console()
	endbr64
	push	rbp
	mov	rbp, rsp
	lea	r11, -16384[rsp]
.LPSRL0:                          
	sub	rsp, 4096
	or	DWORD PTR [rsp], 0
	cmp	rsp, r11
	jne	.LPSRL0
	sub	rsp, 3632
	lea	rax, -10016[rbp]    # get_string(str1);
	mov	rdi, rax
	call	get_string      # get_string()
	lea	rax, -20016[rbp]    # get_string(str2);
	mov	rdi, rax
	call	get_string      # get_string()
	lea	rax, .LC0[rip]      # file1 = fopen("input1.txt", "w");
	mov	rsi, rax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	call	fopen@PLT       # fopen()
	mov	QWORD PTR -8[rbp], rax
	lea	rax, .LC0[rip]      # file2 = fopen("input2.txt", "w");
	mov	rsi, rax
	lea	rax, .LC2[rip]
	mov	rdi, rax
	call	fopen@PLT       # fopen()
	mov	QWORD PTR -16[rbp], rax
	mov	rdx, QWORD PTR -8[rbp]
	lea	rax, -10016[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	fputs@PLT        # fputs()
	mov	rdx, QWORD PTR -16[rbp]
	lea	rax, -20016[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	fputs@PLT        # fputs()
	mov	rax, QWORD PTR -8[rbp] # fclose(file1);
	mov	rdi, rax
	call	fclose@PLT         # fclose()
	mov	rax, QWORD PTR -16[rbp] # fclose(file2);
	mov	rdi, rax
	call	fclose@PLT         # fclose()
	nop
	leave
	ret                        # return
	.size	console, .-console
