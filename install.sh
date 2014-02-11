#!/bin/bash

#https://github.com/xiaoq-in/lighttpd-mariadb-piwik

#Update
apt-get update
apt-get upgrade 

#Install Lighttpd lastest with PHP-FPM
sudo apt-get install lighttpd php5-cgi

#Install MariaDB
sudo apt-get install software-properties-common
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
sudo add-apt-repository 'deb http://mirror.jmu.edu/pub/mariadb/repo/10.0/ubuntu saucy main'
sudo apt-get update
sudo apt-get install mariadb-server

#Download Piwik lastest
sudo adduser piwik
# you have to enter password and info
# go to home folder
cd /home/piwik
mkdir domains
cd domains
mkdir cloud.piwik.la # create folder which piwik domain will use
cd cloud.piwik.la
wget http://builds.piwik.org/latest.zip
apt-get install unzip
unzip latest.zip
#copy all contents of piwik folder to public_html 
#or whatever like that.
mv piwik public_html
#chmod for piwik
chown -R www-data:www-data /home/piwik/domains/cloud.piwik.la/public_html
chmod -R 755 public_html

#Config lighttpd,php
#Enable the fastcgi module and the php configuration with 
sudo lighty-enable-mod fastcgi 
sudo lighty-enable-mod fastcgi-php

# Install GD Graphics Library 
apt-get install php5-gd
# install Json ext php
apt-get install php5-json

#go to piwik folder
cd /home/piwik/domains/cloud.piwik.la/public_html
wget http://www.adminer.org/latest.php
rm latest.php adminer.php
chmod 755 adminer.php
