global asm_invert:function

%macro invert_pixel 1
        mov r9, 255 ; 255 for subtracting
        mov r10, [r8] ; value of dword
        shr r10, 8*%1 ; getting first byte of dword
        and r10, 0xff ; mask
        sub r9, r10 ; color inversion, 255-value
        shl r9, 8*%1 ; move byte to start of dword
        and r9, 0xff<<8*%1 ; another mask
        mov r11, r9 ; move to temp and first pixel here is done
        sub r15, 1 ; subtract from size - loop exit condition
        jz inverted ; jump if all pixels are processed
%endmacro

asm_invert:
	mov r8, rdi ; array pointer here
	mov r15, rsi ; image size here

invert:
;	mov r9, 255 ; 255 for subtracting
;	mov r10, [r8] ; value of dword
;	shr r10, 8*7 ; getting first byte of dword
;	and r10, 0xff ; mask
;	sub r9, r10 ; color inversion, 255-value
;	shl r9, 8*7 ; move byte to start of dword
;	and r9, 0xff<<8*7 ; another mask
;	mov r11, r9 ; move to temp and first pixel here is done
;	sub r15, 1 ; subtract from size - loop exit condition
;	jz inverted ; jump if all pixels are processed
;
;	mov r9, 255 ; 255 for subtracting
;	mov r10, [r8] ; value of dword
;	shr r10, 8*6 ; getting second byte of dword
;	and r10, 0xff ; mask
;	sub r9, r10 ; color inversion, 255-value
;	shl r9, 8*6 ; move byte to second octet of dword
;	and r9, 0xff<<8*6 ; another mask
;	add r11, r9 ; move to temp and second pixel here is done
;	sub r15, 1 ; subtract from size - loop exit condition
;	jz inverted ; jump if all pixels are processed
;
;	mov r9, 255 ; 255 for subtracting
;	mov r10, [r8] ; value of dword
;	shr r10, 8*5 ; getting first byte of dword
;	and r10, 0xff ; mask
;	sub r9, r10 ; color inversion, 255-value
;	shl r9, 8*5 ; move byte to start of dword
;	and r9, 0xff<<8*5 ; another mask
;	add r11, r9 ; move to temp and first pixel here is done
;	sub r15, 1 ; subtract from size - loop exit condition
;	jz inverted ; jump if all pixels are processed
;
	invert_pixel 7
	invert_pixel 6
	invert_pixel 5
	mov r9, 255 ; 255 for subtracting
	mov r10, [r8] ; value of dword
	shr r10, 8*4 ; getting second byte of dword
	and r10, 0xff ; mask
	sub r9, r10 ; color inversion, 255-value
	shl r9, 8*4 ; move byte to second octet of dword
	and r9, 0xff<<8*4 ; another mask
	add r11, r9 ; move to temp and second pixel here is done
	sub r15, 1 ; subtract from size - loop exit condition
	jz inverted ; jump if all pixels are processed

	mov r9, 255 ; 255 for subtracting
	mov r10, [r8] ; value of dword
	shr r10, 8*3 ; getting first byte of dword
	and r10, 0xff ; mask
	sub r9, r10 ; color inversion, 255-value
	shl r9, 8*3 ; move byte to start of dword
	and r9, 0xff<<8*3 ; another mask
	mov r11, r9 ; move to temp and first pixel here is done
	sub r15, 1 ; subtract from size - loop exit condition
	jz inverted ; jump if all pixels are processed

	mov r9, 255 ; 255 for subtracting
	mov r10, [r8] ; value of dword
	shr r10, 8*2 ; getting second byte of dword
	and r10, 0xff ; mask
	sub r9, r10 ; color inversion, 255-value
	shl r9, 8*2 ; move byte to second octet of dword
	and r9, 0xff<<8*2 ; another mask
	add r11, r9 ; move to temp and second pixel here is done
	sub r15, 1 ; subtract from size - loop exit condition
	jz inverted ; jump if all pixels are processed

	mov r9, 255 ; 255 for subtracting
	mov r10, [r8] ; value of dword
	shr r10, 8*1 ; getting third byte of dword
	and r10, 0xff ; mask
	sub r9, r10 ; color inversion, 255-value
	shl r9, 8*1 ; move byte to third octet of dword
	and r9, 0xff<<8*1 ; another mask
	add r11, r9 ; move to temp and third pixel here is done
	sub r15, 1 ; subtract from size - loop exit condition
	jz inverted ; jump if all pixels are processed

	mov r9, 255 ; 255 for subtracting
	mov r10, [r8] ; value of dword
	shr r10, 8*0 ; getting last byte of dword
	and r10, 0xff ; mask - getting last byte of dword
	sub r9, r10 ; color inversion, 255-value
	shl r9, 8*0 ; move byte to forth octet of dword
	and r9, 0xff ; another mask
	add r11, r9 ; move to temp and last pixel here is done, so dword done, can loop

inverted:
	mov [r8], r11 ; put changed dword back to it's place

	add r8, 8 ; move to next dword
	sub r15, 1 ; subtract from size - loop exit condition
	jnbe invert ; this jump has to consider length, not done now

	ret ; return from function
