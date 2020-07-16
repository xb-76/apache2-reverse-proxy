#! /bin/bash/

# Argument 1: Domain name [github.com]

# Setting up certs
certbot --apache -d $1 -d www.$1
certbot renew --dry-run