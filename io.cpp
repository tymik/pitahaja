#include "io.h"

class Image {
	private:
		CImg<unsigned char> *image;
	public:
		void Image::load(string img_path) {
			if (image)
				delete image;
			image = new CImg<unsigned char> (img_path);
		}
		void Image::save();
		Image::image(null) {};
}
