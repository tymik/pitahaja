pitahaja
========

Assembler project for university.

compiles with:
g++ -ggdb -Wall -o pitahaja pitahaja.cpp io.cpp -lboost_program_options -L/usr/X11R6/lib -lm -lpthread -lX11

dependencies:
apt-get install nasm cimg-dev cimg-doc libboost-dev libboost-all-dev libboost-doc
