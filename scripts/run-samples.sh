#!/bin/bash

die () {
    echo >&2 "$@"
    exit 1
}

echo -e '\n***** Testing clib example with CMake *****\n'
cd /usr/share/cantera/samples/clib
mkdir build
cd build
cmake ..
cmake --build .
./demo || die "clib-cmake failed"

echo -e '\n***** Testing clib example with SCons *****\n'
cd /usr/share/cantera/samples/clib
scons
./demo || die "clib-scons failed"

echo -e '\n***** Testing kinetics1 example with CMake *****\n'
cd /usr/share/cantera/samples/cxx/kinetics1
mkdir build
cd build
cmake ..
cmake --build .
./kinetics1 || die "kinetics1-cmake failed"

echo -e '\n***** Testing kinetics1 example with SCons *****\n'
cd /usr/share/cantera/samples/cxx/kinetics1
scons
./kinetics1 || die "kinetics1-scons failed"

echo -e '\n***** Testing rankine example with pkg-config *****\n'
cd /usr/share/cantera/samples/cxx/rankine
g++ rankine.cpp -o rankine $(pkg-config --cflags cantera --libs)
./rankine || die "rankine-pkgconfig failed"

echo -e '\n***** Testing openmp_ignition example with CMake *****\n'
cd /usr/share/cantera/samples/cxx/openmp_ignition
mkdir build
cd build
cmake ..
cmake --build .
./openmp_ignition || die "openmp_ignition-cmake failed"

echo -e '\n***** Testing openmp_ignition example with SCons *****\n'
cd /usr/share/cantera/samples/cxx/openmp_ignition
scons
./openmp_ignition || die "openmp_ignition-scons failed"

echo -e '\n***** Testing F90 example with CMake *****\n'
cd /usr/share/cantera/samples/f90
mkdir build
cd build
cmake ..
cmake --build .
./demo || die "f90-cmake failed"

echo -e '\n***** Testing F90 example with SCons *****\n'
cd /usr/share/cantera/samples/f90
scons
./demo || die "f90-scons failed"

echo -e '\n***** Testing F77 example with SCons *****\n'
cd /usr/share/cantera/samples/f77
scons
./demo || die "f77-demo failed"
./ctlib || die "f77-ctlib failed"
./isentropic || die "f77-isentropic failed"

echo -e '\n***** Testing binaries with dev package removed *****\n'
apt remove -y libcantera-dev
cd /usr/share/cantera/samples/clib
./demo || die "clib demo without dev failed"

cd /usr/share/cantera/samples/cxx/kinetics1
./kinetics1 || die "kinetics demo without dev failed"

cd /usr/share/cantera/samples/cxx/rankine
./rankine || die "rankine demo without dev failed"
