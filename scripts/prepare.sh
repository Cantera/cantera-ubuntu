#!/bin/bash

die () {
    echo >&2 "$@"
    exit 1
}

mkdir -p /src/packaging
cd /src/cantera
git archive $PACKAGING_BRANCH --output=../packaging/tmp.tar --prefix=cantera/ || die "Branch ${PACKAGING_BRANCH} not found"

cd data/example_data
git archive $BASE_REF --output=../../../packaging/tmp-data.tar --prefix=cantera/data/example_data/ || die "Tag ${BASE_REF} not found in example_data"

cd /src/packaging
rm -rf cantera
cp /src/cantera-ubuntu/cantera_${FULL_VERSION}.orig.tar.gz . || die "Pristine tarball not found"
tar xf tmp.tar
tar xf tmp-data.tar
