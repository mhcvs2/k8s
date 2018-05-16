#!/usr/bin/env bash

CFSSL_URL="https://pkg.cfssl.org/R1.2"

wget "${CFSSL_URL}/cfssl_linux-amd64" -O /usr/local/bin/cfssl

wget "${CFSSL_URL}/cfssljson_linux-amd64" -O /usr/local/bin/cfssljson

chmod +x /usr/local/bin/cfssl /usr/local/bin/cfssljson