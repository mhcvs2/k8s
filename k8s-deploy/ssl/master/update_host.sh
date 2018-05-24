#!/usr/bin/env bash


des_dir=/etc/kubernetes/pki
cp ./*.json ${des_dir}
cd ${des_dir}

hostnames="10.96.0.1,109.105.30.155,109.105.1.253,109.105.1.254,109.105.30.156,109.105.1.209,127.0.0.1,kubernetes.default,kubernetes.default.svc,gcloud.bst-1.cns.bstjpc.com,gcloud.srcb.com"

rm -rf apiserver.pem apiserver-key.pem

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -hostname=${hostnames} \
  -profile=kubernetes \
  apiserver-csr.json | cfssljson -bare apiserver

rm -rf *.json

cd -
ansible-playbook sendapi.yml

