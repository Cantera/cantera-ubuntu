#!/bin/bash

die () {
    echo >&2 "$@"
    exit 1
}

/src/prepare.sh || die "prepare failed"
cd /src/packaging/cantera
debuild -uc -us
