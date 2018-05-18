#!/usr/bin/env bash

des_dir=/etc/etcd/ssl
etcd_ips="109.105.30.155,109.105.30.156,109.105.1.209,109.105.1.208,109.105.30.157,109.105.1.253,109.105."

mkdir -p ${des_dir}
cp ./*.json ${des_dir}
cd ${des_dir}

cfssl gencert \
-ca=etcd-ca.pem \
-ca-key=etcd-ca-key.pem \
-config=ca-config.json \
-hostname="" \
-profile=kubernetes \
etcd-csr.json | cfssljson -bare etcd

rm -rf *.json *.csr

ls .