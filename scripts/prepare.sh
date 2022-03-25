#!/bin/bash

die () {
    echo >&2 "$@"
    exit 1
}

mkdir /src/packaging
cd /src/cantera
git archive v$CTVER --output=../packaging/cantera_${CTVER}.orig.tar.gz --prefix=cantera-${CTVER}/ || die "Tag '$CTVER' not found"
git archive $CTBRANCH --output=../packaging/tmp.tar --prefix=cantera/ || die "Branch ${CTBRANCH} not found"
cd /src/packaging
rm -rf cantera
tar xf tmp.tar
