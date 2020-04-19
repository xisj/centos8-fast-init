# centos8-fast-init
最小化安装centos8 之后， 快速初始化环境， 使新机器最短时间可以上线作为开发机/生产机使用


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
