#/bin/bash

# Usage: to launch an environment for Ubuntu 22.04 pacakges, run:
#
#     ./run.sh 22.04

die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -eq 1 ] || die "Missing required argument for Ubuntu release, e.g. '22.04'"

. ./vars.sh

docker run -it \
       --mount type=bind,source=$HOME/src/cantera,target=/src/cantera,readonly \
       --mount type=bind,source=$HOME/.gnupg,target=/root/gnupg-remote,readonly \
       --mount type=bind,source=$HOME/src/cantera-ubuntu,target=/src/cantera-ubuntu,readonly \
       -e "FULL_VERSION=$FULL_VERSION" \
       -e "BASE_REF=$BASE_REF" \
       -e "PACKAGING_BRANCH=ubuntu${1}-ct${SHORT_VERSION}" \
       -e "PPA_TARGET=${PPA_TARGET}" \
       ${USER}/ctppa:ubuntu${1}
