#!/bin/bash

# This is a script that will install Node.js on a server
# Port 3000 needs to be opened to access
# Author: Liz Dahlstrom

source node_install.sh

echo ""
echo "Attempting to install and start a nodejs instance"

dir="."

if [ -n "$1" ] && [ -d $1 ]; then
              dir=$1
else
              echo "No valid directory specified, using default..."
fi

## Copy the template file
cp node_template.js $dir/app.js

cd $dir

# Update packages
echo "Updating packages..."
sudo apt-get update -qq

installNode

## create node server
echo "installing express"

if npm ls express > /dev/null; then
              echo "express is already installed, skipping..."
else
              sudo npm install express
fi

echo "creating project"

npm init -y

## install pm2

if which pm2 > /dev/null; then
              echo "pm2 is already installed, skipping..."
else
              sudo npm install pm2 -g
fi

pm2 start app.js