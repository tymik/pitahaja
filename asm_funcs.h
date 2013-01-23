#pragma once

extern "C" {
	void asm_grayscale(unsigned char* data, int size);
	void asm_sepia(unsigned char* data, int size);
	void asm_invert(unsigned char* data, int size);
}
