#!/usr/bin/env bash

des_dir=/etc/kubernetes/pki
KUBE_APISERVER="https://gcloud.bst-1.cns.bstjpc.com:6443"

mkdir -p ${des_dir}
cp ./*.json ${des_dir}
cd ${des_dir}

#------------------------------------------------------
echo "generate for api server..."
hostnames="10.96.0.1,109.105.30.155,109.105.30.156,109.105.1.209,127.0.0.1,kubernetes.default,kubernetes.default.svc,gcloud.bst-1.cns.bstjpc.com"
cfssl gencert -initca ca-csr.json | cfssljson -bare ca

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -hostname=${hostnames} \
  -profile=kubernetes \
  apiserver-csr.json | cfssljson -bare apiserver

#------------------------------------------------------
echo "generate for front-proxy..."
cfssl gencert \
  -initca front-proxy-ca-csr.json | cfssljson -bare front-proxy-ca

cfssl gencert \
  -ca=front-proxy-ca.pem \
  -ca-key=front-proxy-ca-key.pem \
  -config=ca-config.json \
  -profile=kubernetes \
  front-proxy-client-csr.json | cfssljson -bare front-proxy-client

#------------------------------------------------------
echo "generate for admin..."
cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -profile=kubernetes \
  admin-csr.json | cfssljson -bare admin

#------------------------------------------------------
echo "generate admin kubeconfig..."
# admin set cluster

kubectl config set-cluster kubernetes \
    --certificate-authority=ca.pem \
    --embed-certs=true \
    --server=${KUBE_APISERVER} \
    --kubeconfig=../admin.conf

# admin set credentials

kubectl config set-credentials kubernetes-admin \
    --client-certificate=admin.pem \
    --client-key=admin-key.pem \
    --embed-certs=true \
    --kubeconfig=../admin.conf

# admin set context

kubectl config set-context kubernetes-admin@kubernetes \
    --cluster=kubernetes \
    --user=kubernetes-admin \
    --kubeconfig=../admin.conf

# admin set default context

kubectl config use-context kubernetes-admin@kubernetes \
    --kubeconfig=../admin.conf

#------------------------------------------------------

echo "generate ssl for controller manager..."

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -profile=kubernetes \
  manager-csr.json | cfssljson -bare controller-manager

#------------------------------------------------------
echo "generate kubeconfig for controller manager..."

kubectl config set-cluster kubernetes \
    --certificate-authority=ca.pem \
    --embed-certs=true \
    --server=${KUBE_APISERVER} \
    --kubeconfig=../controller-manager.conf

# controller-manager set credentials
kubectl config set-credentials system:kube-controller-manager \
    --client-certificate=controller-manager.pem \
    --client-key=controller-manager-key.pem \
    --embed-certs=true \
    --kubeconfig=../controller-manager.conf

# controller-manager set context
kubectl config set-context system:kube-controller-manager@kubernetes \
    --cluster=kubernetes \
    --user=system:kube-controller-manager \
    --kubeconfig=../controller-manager.conf

# controller-manager set default context
kubectl config use-context system:kube-controller-manager@kubernetes \
    --kubeconfig=../controller-manager.conf

#--------------------------------------------------------------------
echo "generate ssl for scheduler..."

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -profile=kubernetes \
  scheduler-csr.json | cfssljson -bare scheduler

#----------------------------------------------------------
echo "generate kubeconfig for scheduler..."
# scheduler set cluster

kubectl config set-cluster kubernetes \
    --certificate-authority=ca.pem \
    --embed-certs=true \
    --server=${KUBE_APISERVER} \
    --kubeconfig=../scheduler.conf

# scheduler set credentials
kubectl config set-credentials system:kube-scheduler \
    --client-certificate=scheduler.pem \
    --client-key=scheduler-key.pem \
    --embed-certs=true \
    --kubeconfig=../scheduler.conf

# scheduler set context
kubectl config set-context system:kube-scheduler@kubernetes \
    --cluster=kubernetes \
    --user=system:kube-scheduler \
    --kubeconfig=../scheduler.conf

# scheduler use default context
kubectl config use-context system:kube-scheduler@kubernetes \
    --kubeconfig=../scheduler.conf

# -------------------------------------------------------
  for NODE in k8s-m1 k8s-m2 k8s-m3; do
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

  for NODE in k8s-m1 k8s-m2 k8s-m3; do
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

#--------------------------------
echo "generate ssl for service account..."

openssl genrsa -out sa.key 2048
openssl rsa -in sa.key -pubout -out sa.pub

rm -rf *.json *.csr scheduler*.pem controller-manager*.pem admin*.pem kubelet*.pem

  for NODE in k8s-m1 k8s-m2 k8s-m3; do
    echo "--- $NODE ---"
    for FILE in $(ls /etc/kubernetes/pki/); do
      scp /etc/kubernetes/pki/${FILE} ${NODE}:/etc/kubernetes/pki/${FILE}
    done
  done

  for NODE in k8s-m1 k8s-m2 k8s-m3; do
    echo "--- $NODE ---"
    for FILE in admin.conf controller-manager.conf scheduler.conf; do
      scp /etc/kubernetes/${FILE} ${NODE}:/etc/kubernetes/${FILE}
    done
  done

ls .