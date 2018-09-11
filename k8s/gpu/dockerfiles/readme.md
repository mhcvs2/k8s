docker run --rm -it registry.bst-1.cns.bstjpc.com:5000/bitnami/mongodb:3.6.5 bash  

mongo mongodb://services.gcloud.srcb.com:23937/scream -uscream -pscream@2016  

db.image.find().pretty()  

db.image.find({"name":"camerausp_caffe2-py2-cuda8-cudnn8"}).pretty() 

db.image.find({"owner":"wen.liu"}).pretty()
db.image.find({"name":"test"}).pretty()

db.image.update({'name':'tt'},{$set:{'name':'caffe2-py2-cuda8-cudnn6','tag':'180702','owner':'admin'}})

db.image.update({'name':'sl1015.liu-cuda8-cudnn7-pytorch'},{$set:{'owner':'admin'}})

db.image.update({'name':'camerausp_caffe2-py2-cuda8-cudnn8'},{$set:{'status':'Saved'}})

db.image.update({'name':'test'},{$set:{'name':'camerausp_caffe2-py2-cuda8-cudnn8','tag':'180910','owner':'wen.liu'}})