docker run --rm -it registry.bst-1.cns.bstjpc.com:5000/bitnami/mongodb:3.6.5 bash  

mongo mongodb://services.gcloud.srcb.com:23937/scream -uscream -pscream@2016  

db.image.find().pretty()  

db.image.find({"name":"tt"}).pretty() 

db.image.update({'name':'tt'},{$set:{'name':'caffe2-py2-cuda8-cudnn6','tag':'180702','owner':'admin'}})