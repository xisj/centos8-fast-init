# centos8-fast-init
最小化安装centos8 之后， 快速初始化环境， 使新机器最短时间可以上线作为开发机/生产机使用


## 一键安装

```
dnf install -y epel-release  dnf-plugins-core
dnf install -y wget git vim lrzsz screen net-tools telnet iftop bind-utils tar psmisc  &&\
wget "https://raw.githubusercontent.com/xisj/centos8-fast-init/master/vps/fast.sh" &&\
screen sh fast.sh 

```
 

## 快速上线
#### 需要先修改 vps.sh  
```
dnf install -y epel-release  dnf-plugins-core &&\
dnf config-manager --set-enabled PowerTools &&\
dnf install -y wget git vim lrzsz screen net-tools telnet iftop bind-utils tar psmisc  &&\
git clone https://github.com/xisj/centos8-fast-init.git &&\
vim centos8-fast-init/vps/lnmp.sh &&\
scp  root@xxxxxxxxxxxxx.com:/data1.tar.gz /data1.tar.gz &&\
cd /  &&\
tar -xzf /data1.tar.gz / &&\
cd /root/centos8-fast-init/vps/ &&\
sh lnmp.sh 


```
### 缓解sshd长时间连接后自动断开的问题
```
ClientAliveInterval 60
ClientAliveCountMax 60
```

### 禁止穷举ssh密码
```
cd centos9-fast-init/vps/
screen sh ban.sh

```
#### 如果被大量穷举， 可以使用正经的fail2ban
```
dnf install fail2ban
systemctl start fail2ban
systemctl enable fail2ban
fail2ban-client ping
fail2ban-client status
```

修改   /etc/fail2ban/jail.conf 

```
[ssh-iptables]
enabled = true
filter = sshd
action = iptables[name=SSH, port=22, protocol=tcp]
#sendmail-whois[name=SSH, dest=your@email.com, sender=fail2ban@email.com]
logpath = /var/log/secure
maxretry = 3
bantime = 370
```

## docker安装centos8:latest 遇到 Failed to download metadata for repo ‘AppStream’ 
```
cd /etc/yum.repos.d/
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
yum update 
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

### docker内部更新时区
```
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime 
```

### 手动个ssh开放更多端口
```

semanage port -m -t ssh_port_t -p tcp 80
```

### 手工安装gcc

https://sourceforge.net/projects/mingw-w64/files/

### 修改环境变量

<img src='https://raw.githubusercontent.com/xisj/centos8-fast-init/master/gcc-install.png' alt='desc demo' />


### 安装ffmpeg
--- ffmpeg 推荐安装ffmpeg* ，这样不会因为缺少库出现奇怪问题
```
dnf -y install https://download.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
dnf -y localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm
dnf -y install --nogpgcheck https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-8.noarch.rpm
dnf -y install http://rpmfind.net/linux/epel/7/x86_64/Packages/s/SDL2-2.0.10-1.el7.x86_64.rpm
dnf install -y ffmpeg*

```

### 安装 youtube-dl
```
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl
```

### 安装秘钥实现免密登陆
```
ssh-keygen -t  rsa   #本地生成秘钥， 若已有可省略
ssh-copy-id -i ~/.ssh/id_rsa.pub  devuser@xisj.com  #将本地秘钥拷贝到服务器
```

### 利用ssh 实现内外网联通
ssh -D :7777 -N admin@example.com

