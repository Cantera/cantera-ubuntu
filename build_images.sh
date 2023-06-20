#!/bin/bash

docker build --build-arg ubuntu_release=20.04 -t $USER/ctppa:ubuntu20.04 .
docker build --build-arg ubuntu_release=22.04 -t $USER/ctppa:ubuntu22.04 .
docker build --build-arg ubuntu_release=22.10 -t $USER/ctppa:ubuntu22.10 .
docker build --build-arg ubuntu_release=23.04 -t $USER/ctppa:ubuntu23.04 .
