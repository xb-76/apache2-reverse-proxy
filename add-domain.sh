#! /bin/bash/

# NOTE: This script edits files in the root sub directories and need sudo
# permission to write to.

# Argument 1: Domain name [github.com]
# Argument 2: Port # of the server [8080]

# Creating webroot directory
if [ ! -d '/var/www/'$1 ]; then
    mkdir '/var/www/'$1
fi

# Creating .htaccess redirect
echo 'RewriteEngine On
<if "%{SERVER_PORT} == 80">
    RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [R=308,L]
</if>
RewriteRule ^(.*) http://127.0.0.1:'$2'/$1 [P]
'  | tee /var/www/$1/.htaccess > /dev/null

# Creating VirtualHost entry
echo '<Directory /var/www/'$1'/>
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>

<VirtualHost *:80>
    ServerName '$1'
    ServerAlias www.'$1'
    DocumentRoot "/var/www/'$1'/"
</VirtualHost>
' | tee -a /etc/apache2/apache2.conf > /dev/null

# Restarting apache for changes to take place
systemctl restart apache2