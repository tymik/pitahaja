global asm_grayscale:function

%macro norm_pixel 1 ; must xor r11, r11 before call norm_pixel 7
	mov r12, [r13]
	and r12, 0xff<<8*%7
	add r11, r12
%endmacro

%macro put_full_reg 1 ; takes value of [r13] and puts normalised pixel in 3 places
	mov [r13], r11
	mov [r13+r14], r11
	mov [r13+r14*2], r11
%endmacro

%macro norm_red 0
	xor r11, r11
	mov r8b, byte [r13]
	mov r12, r8
	and r12, 0xff
	add r11, r12

	mov r8b, [r13+r14]
	mov r12, r8
	and r12, 0xff
	add r11, r12

	mov r8b, [r13+r14*2] ; 2*r14
	mov r12, r8
	and r12, 0xff
	add r11, r12

	mov rax, r11
	cdq
	xor rbx, rbx
	mov rbx, 3
	div rbx
	mov r11, rax

	shl r11, 8*7
	mov [r13], r11
%endmacro

%macro norm_green 0
	xor r11, r11
	neg r14
	mov r8b, [r13+r14] ; -1*r14
	neg r14
	mov r12, r8
	and r12, 0xff
	add r11, r12

	mov r8b, [r13]
	mov r12, r8
	and r12, 0xff
	add r11, r12

	mov r8b, [r13+r14]
	mov r12, r8
	and r12, 0xff
	add r11, r12

	mov rax, r11
	cdq
	xor rbx, rbx
	mov rbx, 3
	div rbx
	mov r11, rax

	shl r11, 8*7
	mov [r13], r11
%endmacro

%macro norm_blue 0
	xor r11, r11
	neg r14
	mov r8b, [r13+r14*2] ; -2*r14
	neg r14
	mov r12, r8
	and r12, 0xff
	add r11, r12

	neg r14
	mov r8b, [r13+r14] ; -1*r14
	neg r14
	mov r12, r8
	and r12, 0xff
	add r11, r12

	mov r8b, [r13]
	mov r12, r8
	and r12, 0xff
	add r11, r12

	mov rax, r11
	cdq
	xor rbx, rbx
	mov rbx, 3
	div rbx
	mov r11, rax

	shl r11, 8*7
	mov [r13], r11
%endmacro

asm_grayscale:
        mov r13, rdi ; array pointer here
        mov r15, rsi ; image size here
	mov rax, rsi ; here size/3 begins
	cdq
	xor rbx, rbx
	mov rbx, 3
	div rbx 
	mov r14, rax ; here size/3 is received, for offset usage

	mov r10, r14 ; for the loop counter r10 is used
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
