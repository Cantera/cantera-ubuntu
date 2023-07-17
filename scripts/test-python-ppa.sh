#!/bin/bash

/src/install-ppa.sh
pip3 install pytest pint

/src/prepare.sh
cd /src/packaging/cantera
python3 -m pytest -vv test/python
