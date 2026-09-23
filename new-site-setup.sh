#!/bin/bash

#=========TO KNOW THE SITE'S NUMBER YOURE SETTING UP===========
site_number=$(<.site_number)
((site_number -= 1))
echo -e "\n==============================SITE$site_number.HTML SETUP============================================\n\n"

#========CREATE THE CODE FILE IN NGINX SETTINGS USING YOUR CODE FILE FOR THE WEBPAGE==========
sudo mkdir -p /var/www/site$site_number
sudo touch /var/www/site$site_number/nginx-debian.html
sudo cp ~/nginx-multisite/websites/site$site_number.html /var/www/site$site_number/site$site_number.html

#==============CONFIGURING THE PORT IN NGINX SETTINGS================
site_port=$((site_number + 8080))

sudo touch /etc/nginx/conf.d/site$site_number.conf

sudo tee /etc/nginx/conf.d/site$site_number.conf > /dev/null <<EOF
server {
    listen $site_port;
    listen [::]:$site_port;
    server_name _;
    root /var/www/site$site_number;
    index site$site_number.html;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF


#=========FIREWALL CONFIGURATION==============
echo -e "\nFirewall configuring new port:"
sudo ufw allow $site_port/tcp
sudo ufw reload
sudo ufw status

echo -e "\n"
#============RESTARTING NGINX===============
sudo systemctl restart nginx
echo -e "\n\n===================================YOUR WEBPAGE CODE========================================\n"
curl http://localhost:$site_port

ip=$(hostname -I | awk '{print $1}')
echo -e "\n\n======================== Link: http://$ip:$site_port ============================"

