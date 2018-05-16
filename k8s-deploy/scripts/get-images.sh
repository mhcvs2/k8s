#!/usr/bin/env bash

private_registry=registry.bst-1.cns.bstjpc.com:5000

master_image_tag=v1.10.0

master_image_names=(
 gcr.io/google_containers/kube-apiserver-amd64
 gcr.io/google_containers/kube-controller-manager-amd64
 gcr.io/google_containers/kube-scheduler-amd64
)

other_images=(
 k8s.gcr.io/pause-amd64:3.1
 gcr.io/google_containers/etcd-amd64:3.1.13
 kairen/haproxy:1.7
 kairen/keepalived:1.2.24
)

pull_tag_push(){
 echo "------------------------------------------"
 local image=$1
 echo "Pull image: ${image}"
 docker pull ${image}
 docker tag ${image} ${private_registry}/${image}
 echo "Push image: ${private_registry}/${image}"
 docker push ${private_registry}/${image}
}

for mi in ${master_image_names[@]}; do
 pull_tag_push ${mi}:${master_image_tag}
done

for i in ${other_images[@]}; do
 pull_tag_push ${i}
done
