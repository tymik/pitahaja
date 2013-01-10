global asm_invert:function

asm_invert:
	mov r8, rdi ; array pointer here
	mov r15, rci ; image size here

invert:
	mov r9, 255 ; 255 for subtracting
	mov r10, [r8] ; value of dword
	shr r10, 24 ; getting first byte of dword
	and r10, 0xff ; mask
	sub r9, r10 ; color inversion, 255-value
	shl r9, 24 ; move byte to start of dword
	and r9, 0xff000000 ; another mask
	mov r11, r9 ; move to temp and first pixel here is done

	mov r9, 255 ; 255 for subtracting
	mov r10, [r8] ; value of dword
	shr r10, 16 ; getting second byte of dword
	and r10, 0xff ; mask
	sub r9, r10 ; color inversion, 255-value
	shl r9, 16 ; move byte to start of dword
	and r9, 0x00ff0000 ; another mask
	add r11, r9 ; move to temp and second pixel here is done

	mov r9, 255 ; 255 for subtracting
	mov r10, [r8] ; value of dword
	shr r10, 8 ; getting third byte of dword
	and r10, 0xff ; mask
	sub r9, r10 ; color inversion, 255-value
	shl r9, 8 ; move byte to start of dword
	and r9, 0x0000ff00 ; another mask
	add r11, r9 ; move to temp and third pixel here is done

	mov r9, 255 ; 255 for subtracting
	mov r10, [r8] ; value of dword
	and r10, 0xff ; mask - getting last byte of dword
	sub r9, r10 ; color inversion, 255-value
	and r9, 0xff ; another mask
	add r11, r9 ; move to temp and last pixel here is done, so dword done, can loop

	mov [r8], r11 ; put changed dword back to it's place

	add r8, 4 ; move to next dword
	sub r15, 4 ; subtract
	jmp invert ; this jump has to consider length, not done now
