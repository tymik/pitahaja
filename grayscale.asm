global asm_grayscale:function

%macro norm_pixel 1 ; must xor r11, r11 before call norm_pixel 7
	xor rax, rax

	mov r12, [r13] ; red
	shr r12, 8*%1
	and r12, 0xff
	add rax, r12

	mov r12, [r13+r14] ; green
	shr r12, 8*%1
	and r12, 0xff
	add rax, r12

	mov r12, [r13+r14*2] ; blue
	shr r12, 8*%1
	and r12, 0xff
	add rax, r12

	cdq ; make rax qword, so div can work
	xor rbx, rbx
	mov rbx, 3
	div rbx
	add r11, rax ; add average to almost final destination

	sub r10, 1 ; decrease the counter
%endmacro

%macro put_full_reg 0 ; takes value of r11 and puts normalised pixel in 3 places
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
full_reg:
	norm_pixel 7
	norm_pixel 6
	norm_pixel 5
	norm_pixel 4
	norm_pixel 3
	norm_pixel 2
	norm_pixel 1
	norm_pixel 0

	ret ; return from function
