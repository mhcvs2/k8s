#!/usr/bin/env bash

image=registry.bst-1.cns.bstjpc.com:5000/jenkins/jnlp-slave-mc-helm:3.10-1

docker build -t ${image} .

docker push ${image}