#!/usr/bin/env bash

docker build -t registry.bst-1.cns.bstjpc.com:5000/get-container-id:20180528 .

docker push registry.bst-1.cns.bstjpc.com:5000/get-container-id:20180528