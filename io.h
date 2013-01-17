#pragma once

#include <string>
#include <CImg.h>

using namespace cimg_library;

class Image {
	private:
		CImg<unsigned char> *image;
	public:
		void load(std::string img_path);
		void save(std::string save_path);
		void run_func( void (*func)(unsigned char*, int) );
};
