

docker logs -f $(docker ps|grep k8s-device-plugin|grep -v pause-amd64|awk '{print $1}')