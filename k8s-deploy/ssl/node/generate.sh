#!/usr/bin/env bash

des_dir=/etc/kubernetes/pki
KUBE_APISERVER="https://gcloud.bst-1.cns.bstjpc.com:6443"

mkdir -p ${des_dir}
cp ./*.json ${des_dir}
cd ${des_dir}

nodes=(
 k8s-master-1
 k8s-master-2
)

# -------------------------------------------------------
  for NODE in ${nodes[@]}; do
    echo "generate kubelet ssl for node $NODE..."
    cp kubelet-csr.json kubelet-$NODE-csr.json;
    sed -i "s/\$NODE/$NODE/g" kubelet-$NODE-csr.json;
    cfssl gencert \
      -ca=ca.pem \
      -ca-key=ca-key.pem \
      -config=ca-config.json \
      -hostname=$NODE \
      -profile=kubernetes \
      kubelet-$NODE-csr.json | cfssljson -bare kubelet-$NODE
  done

  for NODE in ${nodes[@]}; do
    echo "copy kubelet ssl to node $NODE..."
    ssh ${NODE} "mkdir -p /etc/kubernetes/pki"
    for FILE in kubelet-$NODE-key.pem kubelet-$NODE.pem ca.pem; do
      scp /etc/kubernetes/pki/${FILE} ${NODE}:/etc/kubernetes/pki/${FILE}
    done
  done

  for NODE in ${nodes[@]}; do
    echo "generate kubelet kubeconfig for node $NODE..."
    ssh ${NODE} "cd /etc/kubernetes/pki && \
      kubectl config set-cluster kubernetes \
        --certificate-authority=ca.pem \
        --embed-certs=true \
        --server=${KUBE_APISERVER} \
        --kubeconfig=../kubelet.conf && \
      kubectl config set-cluster kubernetes \
        --certificate-authority=ca.pem \
        --embed-certs=true \
        --server=${KUBE_APISERVER} \
        --kubeconfig=../kubelet.conf && \
      kubectl config set-credentials system:node:${NODE} \
        --client-certificate=kubelet-${NODE}.pem \
        --client-key=kubelet-${NODE}-key.pem \
        --embed-certs=true \
        --kubeconfig=../kubelet.conf && \
      kubectl config set-context system:node:${NODE}@kubernetes \
        --cluster=kubernetes \
        --user=system:node:${NODE} \
        --kubeconfig=../kubelet.conf && \
      kubectl config use-context system:node:${NODE}@kubernetes \
        --kubeconfig=../kubelet.conf && \
      rm kubelet-${NODE}.pem kubelet-${NODE}-key.pem"

  done

#--------------------------------

rm -rf *.json *.csr kubelet*.pem

  for NODE in ${nodes[@]}; do
    echo "--- $NODE ---"
    for FILE in $(ls /etc/kubernetes/pki/); do
      scp /etc/kubernetes/pki/${FILE} ${NODE}:/etc/kubernetes/pki/${FILE}
    done
  done

ls .