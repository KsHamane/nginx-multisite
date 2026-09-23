#!/bin/bash

if [ ! -d websites ]; then
	mkdir  ~/nginx-multisite/websites
fi


if [ ! -f .site_number ]; then
	echo 2 > .site_number
fi


site_number=$(<.site_number)


echo "<!-- write your code for youe web page here -->" > ~/nginx-multisite/websites/site$site_number.html
nano ~/nginx-multisite/websites/site$site_number.html


((site_number += 1))
echo "$site_number" > .site_number
