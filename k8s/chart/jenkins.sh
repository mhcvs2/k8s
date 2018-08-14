#!/usr/bin/env bash

mc config host add minio http://minio.gcloud.srcb.com AKIAIOSFODNN7EXAMPLE wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY

./package.sh

./update.sh