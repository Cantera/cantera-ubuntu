#!/bin/bash

cd /src/packaging
dpkg -i cantera-common*.deb python3-cantera_*.deb libcantera*.deb
