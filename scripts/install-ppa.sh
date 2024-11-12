#!/bin/bash

apt install -y software-properties-common
apt-add-repository -y ppa:${PPA_TARGET}
apt install -y python3-cantera libcantera-dev
