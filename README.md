# ubuntu-node-server
Scripts to easily set up an apache -> node reverse proxy with cerbot

# Initialization
#### NOTE: There is a prompt to press <kbd>enter</kbd> when installing Certbot
```
sudo sh ubuntu-server-init.sh
```
This command will install all needed dependencies for the apache reverse proxy and certbot.

# Add Domain
```
sudo sh add-domain.sh [domain] [port]
```
This command does a few things:
<li>Creates a webroot directory for the <b>[domain]</b> under /var/www/</li>
<li>Adds a 'Directory' and 'VirtualHost' entry in /etc/apache2/apache2.conf which will redirect the <b>[domain]</b> to the webroot directory</li>
<li>Creates a '.htaccess' file in the <b>[domain]</b> webroot which will act as a proxy to the internal <b>[port]</b> that the <b>[domain]</b> is being served from</li>

# Install SSL Certificate
#### NOTE: There are multiple prompts to setup the certifiate 
```
sudo sh certbot-domain.sh [domain]
```
This command calls the certbot program to install an SSL certificate for <b>[domain]</b> and then tests the renewal process thereafter.
