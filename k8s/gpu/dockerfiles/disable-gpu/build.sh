#!/usr/bin/env bash

image=registry.bst-1.cns.bstjpc.com:5000/bvlc/caffe-cuda8-sshd:180607

docker build -t $image .

docker push $image
