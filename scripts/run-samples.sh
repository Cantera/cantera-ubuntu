#!/bin/bash

echo -e '\n***** Testing clib example with CMake *****\n'
cd /usr/share/cantera/samples/clib
mkdir build
cd build
cmake ..
cmake --build .
./demo

echo -e '\n***** Testing clib example with SCons *****\n'
cd /usr/share/cantera/samples/clib
scons
./demo

echo -e '\n***** Testing kinetics1 example with CMake *****\n'
cd /usr/share/cantera/samples/cxx/kinetics1
mkdir build
cd build
cmake ..
cmake --build .
./kinetics1

echo -e '\n***** Testing kinetics1 example with SCons *****\n'
cd /usr/share/cantera/samples/cxx/kinetics1
scons
./kinetics1

echo -e '\n***** Testing rankine example with pkg-config *****\n'
cd /usr/share/cantera/samples/cxx/rankine
g++ rankine.cpp -o rankine $(pkg-config --cflags cantera --libs)
./rankine

echo -e '\n***** Testing openmp_ignition example with CMake *****\n'
cd /usr/share/cantera/samples/cxx/openmp_ignition
mkdir build
cd build
cmake ..
cmake --build .
./openmp_ignition

echo -e '\n***** Testing openmp_ignition example with SCons *****\n'
cd /usr/share/cantera/samples/cxx/openmp_ignition
scons
./openmp_ignition

echo -e '\n***** Testing F90 example with CMake *****\n'
cd /usr/share/cantera/samples/f90
mkdir build
cd build
cmake ..
cmake --build .
./demo

echo -e '\n***** Testing F90 example with SCons *****\n'
cd /usr/share/cantera/samples/f90
scons
./demo

echo -e '\n***** Testing F77 example with SCons *****\n'
cd /usr/share/cantera/samples/f77
scons
./demo
./ctlib
./isentropic

echo -e '\n***** Testing binaries with dev package removed *****\n'
apt remove -y libcantera-dev
cd /usr/share/cantera/samples/clib
./demo

cd /usr/share/cantera/samples/cxx/kinetics1
./kinetics1

cd /usr/share/cantera/samples/cxx/rankine
./rankine
