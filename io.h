#pragma once

#include <CImg.h>

using namespace cimg_library;

class Image {
	private:
		CImg<unsigned char> *image;
	public:
		void load(string img_path);
		void save();
		Image();
};
