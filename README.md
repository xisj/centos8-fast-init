# centos8-fast-init
最小化安装centos8 之后， 快速初始化环境， 使新机器最短时间可以上线作为开发机/生产机使用


## 一键安装

```
dnf install -y epel-release  dnf-plugins-core
dnf install -y wget git vim lrzsz screen net-tools telnet iftop bind-utils tar &&\
wget "https://raw.githubusercontent.com/xisj/centos8-fast-init/master/vps/fast.sh" &&\
screen sh fast.sh 

```
 

## 快速上线
#### 需要先修改 vps.sh  
```
dnf install -y epel-release  dnf-plugins-core &&\
dnf config-manager --set-enabled PowerTools &&\
dnf install -y wget git vim lrzsz screen net-tools telnet iftop bind-utils tar &&\
git clone https://github.com/xisj/centos8-fast-init.git &&\
vim centos8-fast-init/vps/lnmp.sh &&\
screen  scp  root@xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.com:/data1.tar.gz /data1.tar.gz &&\
cd /  &&\
tar -xzf data1.tar.gz &&\
cd /root/centos8-fast-init/vps/ 
screen sh lnmp.sh 


```


## 更换阿里源
 

## 替换yum源为ali源
#centos8 对镜像的选择做的不错，一般情况下无需替换
#备份
```
cd /etc/yum.repos.d 
#备份
cp -R /etc/yum.repos.d /etc/bak.yum.repos.d

sed -i 's/mirrorlist=/#mirrorlist=/g' CentOS-*.repo 
sed -i 's/#baseurl=/baseurl=/g' CentOS-*.repo 
sed -i 's/http:\/\/mirror.centos.org/https:\/\/mirrors.aliyun.com/g' CentOS-*.repo  


```
#下载fedora的epel仓库
```
dnf install -y epel-release
```
#刷新数据
```
dnf makecache
```
#更新到最新
```
screen dnf update -y
```
------




## 新上架机器后， 启用网卡
```
vi /etc/sysconfig/network-scripts/ifcfg-ens33
```

#修改 ONBOOT=no  为 ONBOOT=yes

#重启网络服务
```
service network restart
```
#查看ip
```
ip addr
```

> 可选操作：

### 更新时区
```
timedatectl set-timezone "Asia/Shanghai"

```

### 手工安装gcc

https://sourceforge.net/projects/mingw-w64/files/

### 修改环境变量

<img src='https://raw.githubusercontent.com/xisj/centos8-fast-init/master/gcc-install.png' alt='desc demo' />

