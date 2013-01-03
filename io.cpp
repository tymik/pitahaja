#include "io.h"

void Image::load(string img_path) {
	if (image)
		delete image;
	image = new CImg<unsigned char> (img_path);
}

void Image::save();

void Image::run_func( void (*func)(unsigned char*, int) ){
	  if (image)
			   func( image.data(), image.size() );
}
