global asm_grayscale:function



asm_grayscale:
        mov r13, rdi ; array pointer here
        mov r15, rsi ; image size here
	mov rax, rsi ;
	mov rdx, 3
	div rdx 
	mov r14, rax ;

	mov r8b, [r13]
	mov r9b, [r13+r14]
	mov r10b, [r13+2*r14]
	xor r11, r11
	mov r12, r8
	shr r12, 8*7
	and r12, 0xff
	add r11, r12
	mov r12, r9
	shr r12, 8*7
	and r12, 0xff
	add r11, r12
	mov r12, r10
	shr r12, 8*7
	and r12, 0xff
	add r11, r12
	

	ret ; return from function
