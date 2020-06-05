cat /proc/cpuinfo
cat /etc/redhat-release 

dnf install -y wget git vim lrzsz screen net-tools telnet iftop bind-utils &&\
dnf install -y epel-release &&\
dnf makecache &&\
dnf update -y

git clone https://github.com/xisj/centos8-fast-init.git 
cd centos8-fast-init/
sh docker/install.sh

mv ./data1 /


#docker run -d -p 9000:9000 -p 9000:9000/udp --name ss-libev -v /data1/conf/ss:/etc/shadowsocks-libev teddysun/shadowsocks-libev
docker run -d -p 9999:9999 -p 9999:9999/udp --restart=always --name ss-go -v /data1/conf/ss:/etc/shadowsocks-go teddysun/shadowsocks-go



#打开防火墙端口
firewall-cmd --zone=public --add-port=9999/tcp --permanent  
firewall-cmd --zone=public --add-port=9999/udp --permanent  
firewall-cmd --reload

#启用bbr
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p
ip a
reboot

#查看bbr是否生效
sysctl -n net.ipv4.tcp_congestion_control
lsmod | grep bbr
