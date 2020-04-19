# centos8-fast-init
最小化安装centos8 之后， 快速初始化环境， 使新机器最短时间可以上线作为开发机/生产机使用


## 一键安装

```
yum install -y wget git vim lrzsz screen net-tools telnet iftop bind-utils &&\
wget "https://raw.githubusercontent.com/terry2010/centos8-fast-init/master/vps/fast.sh" &&\
screen sh fast.sh 

```
 

## 快速上线
#### 需要先修改 vps.sh  
```
dnf install -y wget git vim lrzsz screen net-tools telnet iftop bind-utils &&\
git clone https://github.com/terry2010/centos8-fast-init.git &&\
vim lnmp.sh &&\
screen  scp  root@zhuikan.com:/data1.tar.gz /data1.tar.gz &&\
cd /  &&\
tar -xzf data1.tar.gz &&\
cd /root/centos8-fast-init/vps/ 
screen sh lnmp.sh 


```


## 更换阿里源
```
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-8.repo
```

## 替换yum源为ali源

#备份
```
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
```
#替换
```
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-8.repo
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
> 可选操作：

### 更新时区
```
dnf -y install chrony
timedatectl set-timezone "Asia/Shanghai"

```
