docker stop my-nginx

wget https://dl.eff.org/certbot-auto
sudo mv certbot-auto /usr/local/bin/certbot-auto
sudo chown root /usr/local/bin/certbot-auto
sudo chmod 0755 /usr/local/bin/certbot-auto
/usr/local/bin/certbot-auto --help


/usr/local/bin/certbot-auto certonly --standalone --email xxx@126.com -d xxx.xxx.net


# crontab

0 3 1 * *  /usr/local/bin/certbot-auto renew --renew-hook "docker restart my-nginx&&docker restart trojan"


docker start my-nginx

#证书在 /etc/letsencrypt/ 下面， 需要手工备份

docker pull trojangfw/trojan

docker run -d --name trojan --restart always -p 443:443 -v /data1/conf/trojan/config.json:/config/config.json -v /etc/letsencrypt/live/video.lomoq.net/cert.pem:/config/cert.pem -v /etc/letsencrypt/live/video.lomoq.net/privkey.pem:/config/privkey.pem trojangfw/trojan
