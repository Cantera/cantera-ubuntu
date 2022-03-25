#!/bin/bash

cd /src
./prepare.sh
cd /src/packaging/cantera
rm -rf /root/.gnupg
cp -a /root/gnupg-remote /root/.gnupg
debuild -S -sa
dput ppa:$PPA_TARGET ../cantera_${CTVER}*source.changes
