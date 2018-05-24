<pre><code>
helm create test-pv

helm install test-pv

helm install test-pv --name=mhc

helm repo index /root/github/docker/k8s/chart --url http://minio.gcloud.srcb.com/charts

helm package minio/

helm repo add srcb http://minio.gcloud.srcb.com/charts

mc config host add minio http://minio.gcloud.srcb.com AKIAIOSFODNN7EXAMPLE wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY

helm completion bash > /etc/bash_completion.d/helm




</code></pre>