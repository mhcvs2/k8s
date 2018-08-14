#!/usr/bin/env bash

image=registry.gcloud.srcb.com/cuda8.0-cudnn6-caffe2
tag=$(date +'%y%m%d')

docker build --build-arg http_proxy=http://109.105.4.17:8119 --build-arg https_proxy=http://109.105.4.17:8119 \
    -t ${image}:${tag} .

docker push ${image}:${tag}