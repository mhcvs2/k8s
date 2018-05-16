#!/usr/bin/env bash

docker build --build-arg http_proxy=http://109.105.4.17:8119 --build-arg https_proxy=http://109.105.4.17:8119 -t registry.bst-1.cns.bstjpc.com:5000/tensorflow-sshd:0.11.0rc0-gpu .