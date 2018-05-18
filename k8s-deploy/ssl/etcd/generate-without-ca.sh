#!/usr/bin/env bash

des_dir=/etc/etcd/ssl

mkdir -p ${des_dir}
cp ./*.json ${des_dir}
cd ${des_dir}

cfssl gencert \
-ca=etcd-ca.pem \
-ca-key=etcd-ca-key.pem \
-config=ca-config.json \
-profile=kubernetes \
etcd-csr.json | cfssljson -bare etcd

rm -rf *.json *.csr

ls .