#!/bin/bash

docker build --build-arg ubuntu_release=20.04 -t $USER/ctppa:ubuntu20.04 .
docker build --build-arg ubuntu_release=22.04 -t $USER/ctppa:ubuntu22.04 .
docker build --build-arg ubuntu_release=24.04 -t $USER/ctppa:ubuntu24.04 .
docker build --build-arg ubuntu_release=24.10 -t $USER/ctppa:ubuntu24.10 .
