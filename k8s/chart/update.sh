#!/usr/bin/env bash

upload_file(){
 file_path=$1
 if ! test -f ${file_path}; then
  echo "${file_path} is not exist"
  exit 1
 fi
 file_name=${file_path##*/}
 echo "upload ${file_path}..."
 cat ${file_path} |mc pipe minio/charts/${file_name}
 echo "done"
}

in_array(){
 item=$1
 shift 1
 array=$@
 for i in ${array[@]}; do
   if [ "${i}" == "${item}" ]; then
     echo 1
     return
   fi
 done
 echo 0
 return
}

upload_tgz(){
  remote_files=$(mc ls minio/charts | awk '{print $5}'|grep '.tgz')
  local_files=$(ls . |grep '.tgz')
  for lf in ${local_files[@]}; do
    if [ $(in_array ${lf} ${remote_files[@]}) -eq 0 ]; then
      upload_file ./${lf}
    fi
  done
}

main(){
  helm repo index . --url http://s3.gcloud.bst-1.cns.bstjpc.com/charts
  upload_file ./index.yaml
  upload_tgz
}

main
helm repo update

