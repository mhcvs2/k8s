<pre>
1. /etc/hosts

109.105.30.155 k8s-m1
109.105.30.156 k8s-m2
109.105.1.208 k82-m3

2. 所有节点上都有kubelet 和 kubectl 可执行文件

3. ansible
/etc/ansible/hosts

[k8s-m]
109.105.30.155
109.105.30.156
109.105.1.208

4. cni
所有节点 /opt/cni/bin

5. kubectl taint nodes k8s-m1 k8s-m2 dedicated=master:NoSchedule

</pre>