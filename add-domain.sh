#! /bin/bash/

# NOTE: This script edits files in the root sub directories and need sudo
# permission to write to.

# Argument 1: Domain name [github.com]
# Argument 2: Port # of the server [8080]

# Creating .htaccess redirect
mkdir '/var/www/'$1
echo 'RewriteEngine On
RewriteRule ^(.*) http://localhost:'$2'/$1 [P]'  | tee -a /var/www/$1/.htaccess > /dev/null

# Creating VirtualHost entry
echo '
<Directory /var/www/'$1'/>
Options Indexes FollowSymLinks
AllowOverride All
Require all granted
</Directory>

<VirtualHost *:80>
ServerName '$1'
ServerAlias www.'$1'
DocumentRoot "/var/www/'$1'/"
</VirtualHost>' | tee -a /etc/apache2/apache2.conf > /dev/null

systemctl restart apache2