#!/bin/bash
apt-get -y install software-properties-common python-software-properties
apt-get install autoconf automake build-essential libass-dev libfreetype6-dev -y

sudo apt-add-repository multiverse && apt-get update -y
sudo apt-get install ubuntu-restricted-extras

apt-get -y install libssh2-1-dev libssh2-php

### IMPORTANT ###
# mysql root password must be:   mysqlpassword
# for this guide to work. You must change it after testing.
apt-get install php5-fpm -y
apt-get install mysql-server-5.6 -y

mysql -uroot -e "create database iptv" -p
sudo apt-get install apache2
sudo mysql_install_db
a2enmod rewrite
sudo apt-get install php5 libapache2-mod-php5 php5-mcrypt -y
wget -O /etc/apache2/apache2.conf http://innursery.alwaysdata.net/installation/apache2.conf
wget -O /etc/php5/apache2/php.ini http://innursery.alwaysdata.net/installation/php.ini
service apache2 restart
service php5-fpm restart

wget http://innursery.alwaysdata.net/installation/iptv.sql
mysql -u root -pmysqlpassword iptv < iptv.sql

wget -O /var/www.zip http://innursery.alwaysdata.net/installation/www.zip
sudo apt-get install unzip
unzip /var/www.zip -d /var/
sudo chmod -R 777 /var/www/html/wp-content

apt-get -y install libpcre3 libpcre3-dev libxml2 libxml2-dev libxslt1-dev libssl-dev git
apt-get install libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev -y 
apt-get install libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev pkg-config texi2html zlib1g-dev -y
apt-get install yasm libx264-dev libopus-dev lame -y
apt-get install libxml2-dev libbz2-dev libcurl4-openssl-dev libmcrypt-dev libmhash2 -y
apt-get install libmhash-dev libpcre3 libpcre3-dev make build-essential libxslt1-dev git libssl-dev -y
apt-get install libapache2-mod-php5 php5 php5-mysql phpmyadmin php5-fpm unzip -y
mkdir /usr/build
cd /usr/build
git clone git://github.com/arut/nginx-rtmp-module.git
wget http://nginx.org/download/nginx-1.8.0.tar.gz
tar xzf nginx-1.8.0.tar.gz
cd nginx-1.8.0
./configure --add-module=/usr/build/nginx-rtmp-module --with-http_ssl_module --with-http_xslt_module --with-http_auth_request_module
make
make install
wget https://raw.github.com/JasonGiedymin/nginx-init-ubuntu/master/nginx -O /etc/init.d/nginx
chmod +x /etc/init.d/nginx
update-rc.d nginx defaults
wget -O /usr/local/nginx/conf/nginx.conf http://innursery.alwaysdata.net/installation/nginx.conf
service nginx start
wget -O /usr/local/bin/streaming http://innursery.alwaysdata.net/installation/streaming
sudo chmod +x /usr/local/bin/streaming
sudo apt-get -y install curl php5-curl screen ifstat -y
mkdir /var/www/hlsstream
mkdir /etc/vod
mkdir /usr/local/bin/channels
mkdir /usr/local/bin/channels/conf.d
mkdir /usr/local/bin/channels/logs
mkdir /usr/local/bin/channels/access
chmod -R 777 /var/www/hlsstream
chmod -R 777 /etc/vod
chmod -R 777 /usr/local/bin/channels
chmod -R 777 /usr/local/bin/channels/conf.d
chmod -R 777 /usr/local/bin/channels/logs
chmod -R 777 /usr/local/bin/channels/access
cp /var/www/html/wp-content/plugins/instant-iptv/include/ffmpeg /usr/local/bin/channels/
rm /var/www/html/index.html

####### IMPORTANT ##########
##update DOMAIN.com with your DOMAIN address or IP_ADDRESS of VPS Make sure you use the full address such as http://your.address.here     not just     your.address.here

mysql -u root -pmysqlpassword -D iptv -e "UPDATE wp_options SET option_value = 'DOMAIN.COM/IP' WHERE option_id = '1'";
mysql -u root -pmysqlpassword -D iptv -e "UPDATE wp_options SET option_value = 'DOMAIN.COM/IP' WHERE option_id = '2'";


