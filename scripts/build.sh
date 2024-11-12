#!/bin/bash

die () {
    echo >&2 "$@"
    exit 1
}

/src/prepare.sh || die "prepare failed"
cd /src/packaging/cantera

CT_GIT_COMMIT=`git --git-dir=/src/cantera/.git rev-list -n1 $BASE_REF`
debuild --set-envvar=CT_GIT_COMMIT=$CT_GIT_COMMIT -uc -us
