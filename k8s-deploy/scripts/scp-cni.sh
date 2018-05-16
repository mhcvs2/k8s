#!/usr/bin/env bash

local_dir=/root/packet/kubernetes-1.10.1/bin/cni-plugins-amd64-v0.6.0
dest_dir=/opt/cni/bin

for node in k8s-m1 k8s-m2 k8s-m3; do
 ssh ${node} mkdir -p ${dest_dir}
 scp ${local_dir}/* ${node}:${dest_dir}
done