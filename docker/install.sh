#非中国大陆网络环境推荐用这个脚本安装
dnf install -y yum-utils  device-mapper-persistent-data  lvm2
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf install -y https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm
dnf install -y docker-ce docker-ce-cli
systemctl start docker
systemctl enable docker
docker version
