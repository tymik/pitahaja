#pragma once

extern "C" {
	asm_monochrome(unsigned char* data, int size);
	asm_sepia(unsigned char* data, int size);
	asm_invert(unsigned char* data, int size);
}
