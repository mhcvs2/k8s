kubernetes quan wei zhi nan  p6
 
 
<pre>
[root@mhc t1]# kubectl get svc
NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
kubernetes   ClusterIP   10.254.0.1     <none>        443/TCP    3d
mysql        ClusterIP   10.0.128.255   <none>        3306/TCP   9s
[root@mhc t1]# 
[root@mhc t1]# 
[root@mhc t1]# mysql -uroot -pmhc.123 -h10.0.128.255 -P3306
Warning: Using a password on the command line interface can be insecure.
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 3
Server version: 5.7.21 MySQL Community Server (GPL)

Copyright (c) 2000, 2017, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> exit
Bye


root@myweb-xgfjz:/usr/local/tomcat# env|grep MYSQL
MYSQL_PORT_3306_TCP_PORT=3306
MYSQL_PORT_3306_TCP=tcp://10.0.128.255:3306
MYSQL_PORT_3306_TCP_PROTO=tcp
MYSQL_PORT_3306_TCP_ADDR=10.0.128.255
MYSQL_SERVICE_PORT=3306
MYSQL_PORT=tcp://10.0.128.255:3306
MYSQL_SERVICE_HOST=10.0.128.255

</pre>