FROM registry.gcloud.srcb.com/cuda8.0-cudnn6-caffe2:180702

ENV NVIDIA_VISIBLE_DEVICES void

RUN apt-get update \
&& apt-get install -y openssh-server \
&& apt-get install -y vim \
&& mkdir -p /var/run/sshd \
&& mkdir -p /root/.ssh \
&& sed -ri 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/g' /etc/pam.d/sshd

COPY run.sh /run.sh

COPY nvidia-smi /usr/bin/nvidia-smi

RUN chmod +x /run.sh

CMD ["/run.sh"]



