#!/bin/bash

/src/install-python-local.sh

pip3 install --break-system-packages pytest pint

cd /src/packaging/cantera
rm -rf build

python3 -m pytest -vv test/python
