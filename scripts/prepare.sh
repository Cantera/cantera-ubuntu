#!/bin/bash

mkdir /src/packaging
cd /src/cantera
git archive v$CTVER --output=../packaging/cantera_${CTVER}.orig.tar.gz --prefix=cantera-${CTVER}/
git archive $CTBRANCH --output=../packaging/tmp.tar --prefix=cantera/
cd /src/packaging
rm -rf cantera
tar xf tmp.tar

