#include "io.h"

void Image::load(std::string img_path) {
	if (image)
		delete image;
	//image = & CImg::load<unsigned char> (img_path);
	image = new CImg<unsigned char> (img_path.c_str());
}

void Image::save() {} ;

void Image::run_func( void (*func)(unsigned char*, int) ){
	if (image)
		func( image.data(), image.size() );
}
