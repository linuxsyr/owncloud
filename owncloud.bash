#!/bin/sh
echo "$(tput setaf 2)Thanks for using this script....."
sleep 1s
reset
sleep 1s
echo "$(tput setaf 2)linuxsyr-youtube....."
sleep 1s
reset
apt-get update  # To get the latest package lists
apt install apache2 mariadb-server -y
apt install php7.4 libapache2-mod-php7.4 php7.4-{mysql,intl,curl,json,gd,xml,mbstring,zip} -y
apt install curl gnupg2 -y
apt-cache policy php
add-apt-repository ppa:ondrej/php --yes &> /dev/null
apt update
apt install php7.4
php7.4 -m
apt-cache search php7.4-mysql
apt install php7.4-mysql
apt install php-pear
apt-get install -y libsmbclient-dev php-dev php-pear
apt install mariadb-server 
apt install php7.4 libapache2-mod-php7.4 php7.4-{mysql,intl,curl,json,gd,xml,mbstring,zip} -y
echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/server:/10.9.1/Ubuntu_22.04/ /' > /etc/apt/sources.list.d/isv:ownCloud:server:10.list
curl -fsSL https://download.opensuse.org/repositories/isv:ownCloud:server:10/Ubuntu_20.04/Release.key | gpg --dearmor > /etc/apt/trusted.gpg.d/isv_ownCloud_server_10.gpg
apt update
apt install owncloud-complete-files -y
mkdir /var/www/owncloud
cat > /etc/apache2/sites-available/owncloud.conf << 'EOL'
Alias / "/var/www/owncloud/"

<Directory /var/www/owncloud/>
  Options +FollowSymlinks
  AllowOverride All

 <IfModule mod_dav.c>
  Dav off
 </IfModule>

 SetEnv HOME /var/www/owncloud
 SetEnv HTTP_HOME /var/www/owncloud

</Directory>
EOL
a2ensite owncloud.conf
a2dissite 000-default.conf
a2enmod rewrite mime unique_id
apachectl -t
systemctl restart apache2
mysql_secure_installation
mysql
mysql -u root -p
create database ownclouddb;
grant all privileges on ownclouddb.* to root@localhost identified by "1234";
flush privileges;
quit
exit;
cd /var/www/owncloud
sudo -u www-data php occ maintenance:install \
   --database "mysql" \
   --database-name "ownclouddb" \
   --database-user "root"\
   --database-pass "1234" \
   --admin-user "root" \
   --admin-pass "1234"
