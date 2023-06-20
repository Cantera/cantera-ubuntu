#!/bin/bash

cd /src/packaging
dpkg -i cantera-common*.deb libcantera*.deb libcantera-dev*.deb libcantera-fortran*.deb
