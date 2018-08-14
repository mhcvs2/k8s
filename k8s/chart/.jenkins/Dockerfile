FROM registry.bst-1.cns.bstjpc.com:5000/jenkins/jnlp-slave:3.10-1

COPY helm /usr/bin/helm
COPY mc /usr/bin/mc

RUN mc config host add minio http://minio.gcloud.srcb.com AKIAIOSFODNN7EXAMPLE wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY