#!/bin/bash

#=========SETUP THE NGINX SERVICE==========
echo -e "=======Setting up Nginx=======\n\n"
#INSTALL NGINX IF IT'S NOT INSTALLED
if ! command -v nginx >/dev/null --quiet 2>&1; then
	sudo apt update -q && sudo apt install -q -y nginx
fi

sudo systemctl enable --now nginx

#=======GET A STATUS MESSAGE TO MAKE SURE IT'S RUNNING=======
if sudo systemctl is-active --quiet nginx; then
	echo -e "Nginx: active\n\n"
else
	echo -e "Nginx: inactive\n\n"
fi


echo -e "Firewall configuration:\n"
#========CONFIGURING THE FIREWALL TO ALLOW NECESSARY SERVICES========
sudo ufw allow ssh
sudo ufw allow http

#========RELOAD FIREWALL RULES===========
if sudo ufw status | grep -q "Status: active"; then
	sudo ufw reload

else
	sudo ufw enable
fi


#==========MAKE SURE FIREWALL RULES ARE CORRECT=============
sudo ufw status

echo -e "\n\nNginx is ready to use"
