#!/bin/bash

/src/install-python-local.sh

pip3 install pytest pint

cd /src/packaging/cantera
rm -rf build

python3 -m pytest -vv test/python
