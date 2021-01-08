#!/bin/bash

function installWordpress {
        echo ""
        echo "Attempting to install Wordpress..."
        echo ""

        # download and unpack wordpress
        cd /tmp
        curl -O https://wordpress.org/latest.tar.gz
        tar xzvf latest.tar.gz
        touch /tmp/wordpress/.htaccess
        mv /tmp/wordpress/wp-config-sample.php /tmp/wordpress/wp-config.php
        mkdir /tmp/wordpress/wp-content/upgrade

        sudo cp -a /tmp/wordpress/. /var/www/html/
        # open ownership
        sudo chown -R www-data:www-data /var/www/html/

        # add salts
        salt=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)
        echo "$salt" >> /var/www/html/wp-config.php

        password="ez4ujNcC9ATH8sfC"

        #set db name etc
        sed -i "s/^.*DB_NAME.*$/define('DB_NAME', 'acmea');/" /var/www/html/wp-config.php
        sed -i "s/^.*DB_USER.*$/define('DB_USER', 'acmea');/" /var/www/html/wp-config.php
        sed -i "s/^.*DB_PASSWORD.*$/define('DB_PASSWORD', '$password');/" /var/www/html/wp-config.php

        # permissions
        sudo find /var/www/html/ -type d -exec chmod 775 {} \;
        sudo find /var/www/html/ -type f -exec chmod 775 {} \;
}