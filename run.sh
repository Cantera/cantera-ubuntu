#/bin/bash
docker run -it \
       --mount type=bind,source=~/src/cantera,target=/src/cantera,readonly \
       --mount type=bind,source=~/.gnupg,target=/root/gnupg-remote,readonly \
       -e "CTVER=2.6.0b1" \
       -e "CTBRANCH=ubuntu20.04-ct2.6" \
       -e "PPA_TARGET=cantera-team/cantera-unstable" \
       ${USER}/ctppa:ubuntu20.04
