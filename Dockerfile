# syntax=docker/dockerfile:1
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y g++ python3 python3-numpy cython3 libeigen3-dev libboost-dev git scons python3-pip git emacs-nox devscripts debhelper gfortran libsundials-dev liblapack-dev libblas-dev python3-ruamel.yaml libgtest-dev libgmock-dev libfmt-dev libyaml-cpp-dev python3-pip

COPY scripts/* /src/
WORKDIR /src
