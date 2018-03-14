#!/bin/bash
#
apt-get update && apt-get upgrade -y
apt-get install lsb-release nscd curl php5 php5-mysql php5-cli php5-curl unzip -y && apt-get install php5-mcrypt &&  php5enmod mcrypt
service apache2 restart
wget http://downloads.sourceforge.net/project/iptv-md/xtream/www_dir.tar.gz -O /tmp/www_dir.tar.gz
#
if [ -d /var/www/html ];
then
    echo "/var/www/html/ exists."
	tar -zxvf /tmp/www_dir.tar.gz -C /var/www/html/
else
    echo " "
	if [ -d /root/www/ ];
	then
    echo "/var/www/ exist"
    	tar -zxvf /tmp/www_dir.tar.gz -C /var/www/
else
    echo "No Webserver installed?"

fi

fi
