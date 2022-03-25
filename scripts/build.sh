#!/bin/bash

/src/prepare.sh
cd /src/packaging/cantera
debuild -uc -us
