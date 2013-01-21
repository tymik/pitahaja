pitahaja
========

Assembler project for university.

Compiles with:
    
    nasm invert.asm -g -f elf64 -o invert.o; g++ -ggdb -Wall -o pitahaja pitahaja.cpp io.cpp -lboost_program_options -L/usr/X11R6/lib -lm -lpthread -lX11 -I../ invert.o

Dependencies on Ubuntu:
    
    apt-get install nasm cimg-dev cimg-doc libboost-dev libboost-all-dev libboost-doc
