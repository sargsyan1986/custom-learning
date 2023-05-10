#!/bin/bash

apt -y update
apt -y install nginx
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WebServer with IP: $myip</h2><body bgcolor="gray"><br>Build by Hayk on terraform! 
<b>Version 3.0</b>" > /var/www/html/index.html
sudo service nginx start
