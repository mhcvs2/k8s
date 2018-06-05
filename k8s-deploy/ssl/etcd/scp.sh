#!/usr/bin/env bash

for NODE in k8s-m1 k8s-m2 k8s-m3 k8s-n1 k8s-n2 k8s-n3 k8s-n4 k8s-master-1 k8s-master-2; do

    echo "--- $NODE ---"

    ssh ${NODE} "mkdir -p /etc/etcd/ssl"

    for FILE in etcd-ca-key.pem  etcd-ca.pem  etcd-key.pem  etcd.pem; do

      scp /etc/etcd/ssl/${FILE} ${NODE}:/etc/etcd/ssl/${FILE}

    done

  done