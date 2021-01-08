#!/bin/bash

# servername="acmeb.ld222me-1dv031.devopslab.xyz"
# server1="192.168.20.64:3000"
# server2="192.168.20.66:3000"
function buildConf {
echo ""
echo "Setting up the conf file"
read -p "server_name: " servername
read -p "server 1: " server1
read -p "server 2: " server2

cat > /etc/nginx/conf.d/"$servername".conf <<EOF
upstream backend {
        server $server1;
        server $server2;
}

server {
        listen 80;
        listen [::]:80;

        server_name $servername;

        #root /var/www/html;
        #index index.html index.nginx-debian.html;

        location / {
                proxy_pass http://backend;
        }
}
EOF

}