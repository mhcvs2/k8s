#!/usr/bin/env bash


docker build -t registry.bst-1.cns.bstjpc.com:5000/docker-commit-push:18.03.0-ce .

docker push registry.bst-1.cns.bstjpc.com:5000/docker-commit-push:18.03.0-ce