docker stop my-nginx

wget https://dl.eff.org/certbot-auto
sudo mv certbot-auto /usr/local/bin/certbot-auto
sudo chown root /usr/local/bin/certbot-auto
sudo chmod 0755 /usr/local/bin/certbot-auto
/usr/local/bin/certbot-auto --help


/usr/local/bin/certbot-auto certonly --standalone --email jstel@126.com -d video.lomoq.net


# crontab

0 3 1 * *  /usr/local/bin/certbot-auto renew --renew-hook "docker restart my-nginx"


docker start my-nginx
