global asm_grayscale:function

%macro norm_red 0
	xor r11, r11
	mov r8b, [r13]
	mov r12, r8
	shr r12, 8*7
	and r12, 0xff
	add r11, r12

	mov r8b, [r13+r14]
	mov r12, r8
	shr r12, 8*7
	and r12, 0xff
	add r11, r12

	mov r8b, [r13+r14*2] ; 2*r14
	mov r12, r8
	shr r12, 8*7
	and r12, 0xff
	add r11, r12

	mov r8b, r11b
%endmacro

%macro norm_green 0
	xor r11, r11
	neg r14
	mov r8b, [r13+r14] ; -1*r14
	neg r14
	mov r12, r8
	shr r12, 8*7
	and r12, 0xff
	add r11, r12

	mov r8b, [r13]
	mov r12, r8
	shr r12, 8*7
	and r12, 0xff
	add r11, r12

	mov r8b, [r13+r14]
	mov r12, r8
	shr r12, 8*7
	and r12, 0xff
	add r11, r12

	mov r8b, r11b
%endmacro

%macro norm_blue 0
	xor r11, r11
	neg r14
	mov r8b, [r13+r14*2] ; -2*r14
	neg r14
	mov r12, r8
	shr r12, 8*7
	and r12, 0xff
	add r11, r12

	neg r14
	mov r8b, [r13+r14] ; -1*r14
	neg r14
	mov r12, r8
	shr r12, 8*7
	and r12, 0xff
	add r11, r12

	mov r8b, [r13]
	mov r12, r8
	shr r12, 8*7
	and r12, 0xff
	add r11, r12

	mov r8b, r11b
%endmacro

asm_grayscale:
        mov r13, rdi ; array pointer here
        mov r15, rsi ; image size here
	mov rax, rsi ;
	mov rdx, 3
	div rdx 
	mov r14, rax ;

	mov r10, r14
red:
	norm_red
	add r13, 1
	sub r10, 1
	jnz red

	mov r10, r14
green:
	norm_green
	add r13, 1
	sub r10, 1
	jnz green

	mov r10, r14
blue:
	norm_blue
	add r13, 1
	sub r10, 1
	jnz blue


	ret ; return from function
