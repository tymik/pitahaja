#include <iostream>
#include <iterator>
#include <string>

#include <boost/program_options.hpp>

using namespace std;
#include "io.h"
#include "asm_funcs.h"

namespace po = boost::program_options;

void menu (int argc, char* argv[]) {
const char *img_path="images/FF7F3F_25x25.png";
const char *img_path2="images/3F7FFF_25x25.png";
const char *img_path3="images/FF6600_25x25.png";

	po::options_description desc("Usage:\npitahaja [options] source destination");
	desc.add_options()
		("help", "shows this short help")
		("placeholder", "placeholder")
		("tryimg", "test calling an image")
		("tryimg2", "test calling an image 2")
	;
	
	po::variables_map param;
	po::store(po::parse_command_line(argc, argv, desc), param);
	po::notify(param);

	if (param.count("help")) 
		cout << desc << "\n";
	else if (param.count("placeholder"))
		cout << "Just a placeholder\n";
	else if (param.count("tryimg")) {
		Image image = Image();
		image.load(img_path3);
		image.run_func(asm_grayscale);
		image.save("images/save_test.png");
	}
	else if (param.count("tryimg2")) {
		Image image = Image();
		image.load(img_path2);
		image.run_func(asm_invert);
		image.save("images/save_test2.png");
	}
	else {
		cout << "Not a valid execution arguments\n";
		cout << desc << "\n";
	}


}

int main (int argc, char* argv[]) {

	menu(argc,argv);
	return 0;
}
