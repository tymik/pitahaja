global asm_invert:function

%macro invert_pixel 1
        mov r9, 0xff<<8*%1 ; 255 for subtracting
        mov r10, [r8] ; value of dword
;        shr r10, 8*%1 ; getting first byte of dword
        and r10, 0xff<<8*%1 ; mask
        sub r9, r10 ; color inversion, 255-value
;        shl r9, 8*%1 ; move byte to start of dword
;        and r9, 0xff<<8*%1 ; another mask
        or r11, r9 ; move to temp and first pixel here is done
        sub r15, 1 ; subtract from size - loop exit condition
        jz inverted ; jump if all pixels are processed
%endmacro

asm_invert:
	mov r8, rdi ; array pointer here
	mov r15, rsi ; image size here

invert:
	xor r11, r11 ; r11 = 0
	invert_pixel 7
	invert_pixel 6
	invert_pixel 5
	invert_pixel 4
	invert_pixel 3
	invert_pixel 2
	invert_pixel 1
	invert_pixel 0

inverted:
	mov [r8], r11 ; put changed dword back to it's place

	add r8, 8 ; move to next dword
	sub r15, 0 ; subtract from size - loop exit condition
	jnbe invert ; this jump has to consider length, not done now

	ret ; return from function
