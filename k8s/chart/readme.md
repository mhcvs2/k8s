<pre><code>
helm create test-pv

helm install test-pv

helm install test-pv --name=mhc

helm repo index /root/github/docker/k8s/chart --url http://s3.gcloud.bst-1.cns.bstjpc.com/charts
helm package minio/
helm repo add s3 http://s3.gcloud.bst-1.cns.bstjpc.com/charts

mc config host add minio http://s3.gcloud.bst-1.cns.bstjpc.com AKIAIOSFODNN7EXAMPLE wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY

helm completion bash > /etc/bash_completion.d/helm




</code></pre>