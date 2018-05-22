endpoint
---
https://109.105.4.65:6443/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy

<pre>
<code>
生成自签名证书

# mkdir cert && cd cert
# cp /etc/pki/tls/openssl.cnf .
修改 openssl.cnf

# 主要修改如下
[req]
req_extensions = v3_req # 这行默认注释关着的 把注释删掉
# 下面配置是新增的
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = dashboard.mritd.me
DNS.2 = kibana.mritd.me

运行 tls.sh

kubectl create secret tls dashboard-ingress-secret --key ingress-key.pem --cert ingress.pem -n kube-system
</code>
</pre>