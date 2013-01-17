#include "io.h"

void Image::load(std::string img_path) {
	if (image)
		delete image;
	image = new CImg<unsigned char> (img_path.c_str());
}

void Image::save(std::string save_path) {
	image->save(save_path.c_str());
} 

void Image::run_func( void (*func)(unsigned char*, int) ){
	if (image)
		func( image->data(), image->size() );
}
