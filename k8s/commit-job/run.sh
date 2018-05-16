#!/usr/bin/env sh

#POD_NAME=haha
#IMAGE_NAME=registry.bst-1.cns.bstjpc.com:5000/docker-test
#IMAGE_TAG=test
#AUTHOR="mhc haha"
#MESSAGE="describe aa"

pod_name=${POD_NAME}
image_name=${IMAGE_NAME}
image_tag=${IMAGE_TAG}
author=${AUTHOR}
message=${MESSAGE}

exitIfError(){
 if [ $? -ne 0 ]; then
  echo $1
  exit 1
 fi
}

exitIfNull(){
 if [ "$1" = "x" ]; then
  echo $2
  exit 1
 fi
}

gen_docker_cmd(){
 docker_cmd=$(which docker)
 exitIfError "docker command not found"
}

gen_commit_cmd(){
 commit_cmd="${docker_cmd} commit"
 if [ "${author}" != "" ]; then
  commit_cmd="${commit_cmd} --author=\"${author}\""
 fi
 if [ "${message}" != "" ]; then
  commit_cmd="${commit_cmd} --message=\"${message}\""
 fi
}

gen_push_cmd(){
 push_cmd="${docker_cmd} push"
}

run_cmd(){
 echo $@
 eval $@
 exitIfError "Command \"$*\" execute error"
}

main(){
 gen_docker_cmd
 gen_commit_cmd
 gen_push_cmd

 if [ "${image_tag}" = "" ]; then
  image_tag=latest
 fi

 container_id=$(docker ps|grep "${pod_name}"|grep -v pause-amd64|awk '{print $1}')
 exitIfNull x${container_id} "Can't find active container of pod ${pod_name}"

 run_cmd "${commit_cmd} ${container_id} ${image_name}:${image_tag}"
 run_cmd "${push_cmd} ${image_name}:${image_tag}"
}

main