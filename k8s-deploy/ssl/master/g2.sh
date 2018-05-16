#!/usr/bin/env bash

KUBE_APISERVER="https://gcloud.bst-1.cns.bstjpc.com:6443"

  for NODE in k8s-m3; do
    echo "copy kubelet ssl to node $NODE..."
    ssh ${NODE} "mkdir -p /etc/kubernetes/pki"
    for FILE in kubelet-$NODE-key.pem kubelet-$NODE.pem ca.pem; do
      scp /etc/kubernetes/pki/${FILE} ${NODE}:/etc/kubernetes/pki/${FILE}
    done
  done

  for NODE in k8s-m1 k8s-m2 k8s-m3; do
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