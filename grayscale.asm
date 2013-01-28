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
	add r13, 8
%endmacro

%macro norm_unfull 1 ; normalization for images with dimension not being multiply of 8
	xor rbp, rbp
	xor rsp, rsp

	mov rbp, [r13] ; tmp1 changed from rax
	mov rsp, [r13] ; tmp2 changed from rcx
	mov rbx, 0xFFFFFFFFFFFFFFFF ; mask, changed from rdx

	xor rax, rax
	mov rax, %1 ; storing 'n' here
	shl rax, 3 ; multiply by 8, so 'n' fits the needs
	neg rax ; we get '(-n)'
	add rax, 8*8 ; here we have 8-n
	mov rcx, rax ; and here we're ready to do shifting
	

	shr rbp, cl ; tmp1 shifting
	shr rsp, cl ; tmp2 shifting
	and rbp, rsp
	shl rsp, cl

	xor rax, rax
	mov rax, %1 ; storing 'n' here
	shl rax, 3 ; multiply by 8, so 'n' fits the needs
	mov rax, rcx

	shr rbp, cl
	shr rbx, cl
	and rbp, rbx
	
	add rbp, rsp
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

	put_full_reg

	cmp r10, 8
	jnb full_reg ; if there is still at least one full register to convert
	jz end ; if there were only full registers to be processed

	xor r11, r11
unfull:
	norm_unfull r10
	sub r10, 1
	jnbe unfull

	add r11, rbp
	put_full_reg

end:
	ret ; return from function
