#!/bin/bash

t=/etc/kubernetes

fs=$(ls $t|grep ".conf")



for f in ${fs[@]}; do
  sed -i 's/gcloud.bst-1.cns.bstjpc.com/gcloud.srcb.com/g' $t/$f
done