#! /bin/bash

# TIP: Make sure to set firewall such that ports 80 and 443 are open

# Initial dependencies
apt install -y apache2 curl

# Configuring apache2 mods
a2enmod ssl
a2enmod proxy
a2enmod proxy_http

# Installing Certbot
wget https://dl.eff.org/certbot-auto -O /usr/sbin/certbot-auto
chmod a+x /usr/sbin/certbot-auto
add-apt-repository ppa:certbot/certbot
apt install -y python-certbot-apache

# Enabling ports 80 and 443 in apache
ufw allow 'Apache Full'
ufw delete allow 'Apache'

# Restarting apache to init changes
systemctl restart apache2
