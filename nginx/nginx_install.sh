#!/bin/bash

source nginx_build_conf.sh


if which nginx > /dev/null; then
              echo "nginx is already installed, skipping..."
else
              sudo apt-get update
              sudo apt-get install nginx -y
fi

## create a config file
buildConf

# Unlink default site
sudo unlink /etc/nginx/sites-enabled/default
sudo nginx -s reload
