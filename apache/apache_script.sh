#!/bin/bash

source wordpress_script.sh

# INSTALL MARIADB
echo "updating packages..."
sudo apt-get update -y

echo ""
echo "Installing Apache and wordpress..."
echo ""

# 1) install mariadb
if which mariadb > /dev/null; then
  echo "mariadb is already installed, skipping..."
else
  echo "installing mariadb..."
  sudo apt install mariadb-server -y
fi

password="3qDufY4wUYf5CSya"

# 2) secure the db server
sudo mysql_secure_installation <<EOF
$password
n
y
y
y
y
EOF

# create db and user
mysql -uroot <<MYSQL_SCRIPT
CREATE DATABASE acmea;
GRANT ALL PRIVILEGES ON acmea.* TO "acmea"@"localhost" IDENTIFIED BY "ez4ujNcC9ATH8sfC";
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# INSTALL APACHE

# 1) install apache
if which apache2 > /dev/null; then
  echo "apache is already installed, skipping..."
else
  sudo apt-get install apache2 -y
fi

sudo ufw allow OpenSSH
sudo ufw allow 'Apache Full'
sudo ufw enable -y

# INSTALL PHP
if which php > /dev/null; then
  echo "php is already installed, skipping..."
else
  sudo apt-get install php libapache2-mod-php php-mysql -y
fi

#additional extensions for wordpress
sudo apt-get install php-curl php-gd php-xml php-mbstring php-xmlrpc php-zip php-soap php-intl -y

# rebind /etc/apache2/mods-enabled/dir.conf to index.php
sed -i 's/index.html/index.php/' /etc/apache2/mods-enabled/dir.conf
sed -i 's/index.php/index.html/2' /etc/apache2/mods-enabled/dir.conf

# CONFIG APACHE for wordpress
echo ""
echo "Configuring Apache for WP...."
echo ""

# disable default files and add new
servername="acmea.ld222me-1dv031.devopslab.xyz"

cd /etc/apache2/sites-available
sudo a2dissite 000-default.conf
sudo cp 000-default.conf ./"$servername".conf

cat > "$servername".conf <<EOF
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html/

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
        <Directory /var/www/html/>
          AllowOverride All
        </Directory>
</VirtualHost>
EOF

echo ""
echo "Restart apache"
echo ""

# restart apache to enable changes
sudo a2enmod rewrite
sudo systemctl restart apache2

installWordpress