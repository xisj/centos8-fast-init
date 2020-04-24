dnf install -y samba
#这里的root， 换成真实的用户，需要手动输入密码
smbpasswd -a root
systemctl start smb
systemctl enable smb
systemctl status smb

#打开端口
firewall-cmd --zone=public --add-port=139/tcp --permanent
firewall-cmd --zone=public --add-port=445/tcp --permanent
firewall-cmd --zone=public --add-port=137/udp --permanent
firewall-cmd --zone=public --add-port=138/udp --permanent
 
firewall-cmd --reload


#########当共享root 文件夹的时候， 默认没有写权限
#临时授予，重启后消失
setenforce 0

#永久授予
/etc/selinux/config
#将SELINUX=enforcing改为SELINUX=disabled

