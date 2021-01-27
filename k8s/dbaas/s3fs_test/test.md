yum install fuse-libs

chmod 600 /opt/passwd_s3fs

mkdir /ks3nosplit

```
/opt/s3fs s3fstest /ks3nosplit -o url=http://ks3-cn-beijing-internal.ksyun.com -o sigv2 -o nocopyapi -o multipart_size=40 -o parallel_count=10 -o retries=30 -o allow_other -o mp_umask=000 -o passwd_file=/opt/passwd_s3fs -d -o use_path_request_style
```

