cat /proc/cpuinfo
cat /etc/redhat-release 

dnf install -y epel-release &&\
dnf install -y wget git vim lrzsz screen net-tools telnet iftop bind-utils &&\
dnf makecache &&\
dnf update -y

git clone https://github.com/xisj/centos8-fast-init.git 
cd centos8-fast-init/
sh docker/install.sh


mv ./data1 /


docker run --name my-nginx -d --restart=always --network=host    -e TZ="Asia/Shanghai" -v /data1/conf/nginx:/etc/nginx:ro -v /data1/htdocs:/htdocs:ro  -v /data1/log/nginx:/logs -v /data1/cert/:/cert nginx

docker run --name my-php -d --restart=always --network=host -v /data1/htdocs:/htdocs:ro php:7.3-fpm

#移动配置文件
docker exec -t my-php bash -c "mv /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini"
#安装redis
docker exec -t my-php bash -c "yes '' |pecl install redis"
docker exec -t my-php bash -c "echo \"extension=redis.so\" >> /usr/local/etc/php/php.ini"

#安装yaf
#docker exec -t my-php bash -c "yes '' |pecl install yaf"
#docker exec -t my-php bash -c "echo \"extension=yaf.so\" >> /usr/local/etc/php/php.ini"
#安装mysqli
docker exec -t my-php bash -c "/usr/local/bin/docker-php-ext-install mysqli"

#安装gd
docker exec -t my-php bash -c "apt-get update -y \
        &&apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo_mysql"
#安装swoole
#docker exec -t my-php bash -c "yes '' |pecl install swoole pdo_mysql"
#docker exec -t my-php bash -c "echo \"extension=swoole.so\" >> /usr/local/etc/php/php.ini"
#docker restart my-php
#安装pcntl
docker exec -t my-php bash -c "docker-php-source extract \
    && cd /usr/src/php/ext/pcntl \
    && 	phpize \
    && ./configure && make && make install \
    && echo "extension=pcntl.so" >> /usr/local/etc/php/php.ini \
    && docker-php-source delete"
    
#安装sockets
docker exec -t my-php bash -c "docker-php-source extract \
    && cd /usr/src/php/ext/sockets \
    && 	phpize \
    && ./configure && make && make install \
    && echo "extension=sockets.so" >> /usr/local/etc/php/php.ini \
    && docker-php-source delete"
    
#安装完扩展重启镜像
docker restart my-php
#解决php无法写文件的问题
#只有当php容器挂载目录为可写的时候才需要这么做
#docker exec -t my-php bash -c "chown -R www-data:www-data /htdocs/"

#docker run --name my-mysql -d --network=host -v /data1/data/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=weibo.com mysql:5.7 --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci


#docker run -d -p 9000:9000 -p 9000:9000/udp --name ss-libev -v /data1/conf/ss:/etc/shadowsocks-libev teddysun/shadowsocks-libev
#docker run -d -p 9999:9999 -p 9999:9999/udp --restart=always --name ss-go -v /data1/conf/ss:/etc/shadowsocks-go teddysun/shadowsocks-go

docker run -d --privileged -p 500:500/udp -p 4500:4500/udp --name l2tp --restart=always --env-file /data1/conf/l2tp/l2tp.env -v /lib/modules:/lib/modules teddysun/l2tp


#打开防火墙端口
firewall-cmd --zone=public --add-port=80/tcp --permanent  
firewall-cmd --zone=public --add-port=80/udp --permanent  

firewall-cmd --zone=public --add-port=9999/tcp --permanent  
firewall-cmd --zone=public --add-port=9999/udp --permanent  

firewall-cmd --zone=public --add-port=500/udp --permanent  
firewall-cmd --zone=public --add-port=4500/udp --permanent  

firewall-cmd --reload
firewall-cmd --zone=public --list-ports

#启用bbr
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p
ip a
reboot

#查看bbr是否生效
sysctl -n net.ipv4.tcp_congestion_control
lsmod | grep bbr
