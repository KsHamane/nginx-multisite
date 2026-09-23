#!/bin/bash

#sudo cp ~/nginx-multisite/site1-index.html /usr/share/nginx/html/index.html  #Redhat
sudo cp ~/nginx-multisite/site1-index.html /var/www/html/index.nginx-debian.html  #Debian
#sudo systemctl restart nginx

echo -e "============================YOUR WEBPAGE HTML CODE===========================\n"
curl http://localhost

echo -e "\n\n=========================== Link: http://$(hostname -I) ==========================="
