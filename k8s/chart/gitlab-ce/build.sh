#!/usr/bin/env bash

iname=registry.bst-1.cns.bstjpc.com:5000/gitlab/gitlab-ce:9.4.1-ce-0605

docker build -t ${iname}  .

docker push ${iname}