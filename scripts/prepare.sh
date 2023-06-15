#!/bin/bash

die () {
    echo >&2 "$@"
    exit 1
}

mkdir /src/packaging
cd /src/cantera
git archive $BASE_REF --output=../packaging/cantera_${FULL_VERSION}.orig.tar.gz --prefix=cantera-${FULL_VERSION}/ || die "Tag '$BASE_REF' not found"
git archive $PACKAGING_BRANCH --output=../packaging/tmp.tar --prefix=cantera/ || die "Branch ${PACKAGING_BRANCH} not found"
cd /src/packaging
rm -rf cantera
tar xf tmp.tar
