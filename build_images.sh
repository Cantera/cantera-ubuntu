#!/bin/bash

docker build --build-arg ubuntu_release=20.04 -t $USER/ctppa:ubuntu20.04 .
docker build --build-arg ubuntu_release=21.10 -t $USER/ctppa:ubuntu21.10 .
docker build --build-arg ubuntu_release=22.04 -t $USER/ctppa:ubuntu22.04 .
