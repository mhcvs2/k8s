#!/usr/bin/env bash

CORE_URL="https://kairen.github.io/files/manual-v1.10/master"

for FILE in kube-apiserver kube-controller-manager kube-scheduler haproxy keepalived etcd etcd.config; do
    wget "${CORE_URL}/${FILE}.yml.conf" -O ${FILE}.yml
    if [ ${FILE} == "etcd.config" ]; then
      mv etcd.config.yml /etc/etcd/etcd.config.yml
      sed -i "s/\${HOSTNAME}/${HOSTNAME}/g" /etc/etcd/etcd.config.yml
      sed -i "s/\${PUBLIC_IP}/$(hostname -i)/g" /etc/etcd/etcd.config.yml
    fi
  done


wget "${CORE_URL}/haproxy.cfg"
wget "${CORE_URL}/kubelet.service"
wget "${CORE_URL}/10-kubelet.conf"