#!/bin/bash


for f in scheduler controller-manager; do
  ns=$(docker ps|grep $f |grep -v pause-amd64|awk '{print $1}')
  test -n $ns && docker rm -f $ns
done


for f in apiserver; do
  ns=$(docker ps|grep $f |grep -v pause-amd64|awk '{print $1}')
  test -n $ns && docker rm -f $ns
done