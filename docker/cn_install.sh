#在中国大陆网络环境下， 利用aliyun正常安装docker和相关服务
dnf install -y yum-utils  device-mapper-persistent-data  lvm2
dnf config-manager --add-repo=https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
dnf install -y https://mirrors.aliyun.com/docker-ce/linux/centos/7/x86_64/stable/Packages/containerd.io-1.4.3-3.1.el7.x86_64.rpm
dnf install -y docker-ce docker-ce-cli
systemctl start docker
systemctl enable docker
docker version

#更换为阿里镜像
echo '{
  "registry-mirrors": ["https://md4nbj2f.mirror.aliyuncs.com"]
}' > /etc/docker/daemon.json

systemctl restart docker
systemctl enable docker
