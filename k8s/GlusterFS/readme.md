https://github.com/gluster/gluster-kubernetes
-----------

1. yum install glusterfs glusterfs-fuse -y


2. kubelet 启动加上 --allow-privileged=true

kubectl label node 7dd70763-c067-6232-a90b-d6c1a9eef026 storagenode=glusterfs

scp topology.json 109.105.30.146:/heketi-data

kubectl exec -ti deploy-heketi-7586f6c746-xclxg  bash

export HEKETI_CLI_SERVER=http://localhost:8080

heketi-cli topology load --json=/var/lib/heketi/topology.json

heketi-cli topology info


如果报错，进每一个gluster pod 执行
pvcreate --metadatasize=128M --dataalignment=256K '/dev/vdb1' (-ff)