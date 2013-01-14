#include "io.h"

void Image::load(std::string img_path) {
	if (image)
		delete image;
	image = & CImg::load<unsigned char> (img_path);
}

void Image::save() {} ;

void Image::run_func( void (*func)(unsigned char*, int) ){
	if (image)
		func( image.data(), image.size() );
}
