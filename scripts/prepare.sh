#!/bin/bash

die () {
    echo >&2 "$@"
    exit 1
}

mkdir -p /src/packaging
cd /src/cantera
git archive $PACKAGING_BRANCH --output=../packaging/tmp.tar --prefix=cantera/ || die "Branch ${PACKAGING_BRANCH} not found"
cd /src/packaging
rm -rf cantera
cp /src/cantera-ubuntu/cantera_${FULL_VERSION}.orig.tar.gz . || die "Pristine tarball not found"
tar xf tmp.tar
