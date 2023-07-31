#!/bin/bash
source components/common.sh
COMPONENT=frontend

NGNIX




#CHECK_ROOT
##To Install Nginx.
#
#yum install nginx -y
#systemctl enable nginx
#systemctl start nginx
#
##Let's download the HTDOCS content and deploy under the Nginx path.
#
#curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
#
##Deploy in Nginx Default Location.
#0
#
#cd /usr/share/nginx/html
#rm -rf *
#unzip /tmp/frontend.zip
#mv frontend-main/* .
#mv static/* .
# rm -rf frontend-main README.md
#mv localhost.conf /etc/nginx/default.d/roboshop.conf
#
#sed -i -e '/catalogue/ s/localhost/catalogue.roboshop.internal/' /etc/nginx/default.d/roboshop.conf
#sed -i -e '/user/ s/localhost/user.roboshop.internal/' /etc/nginx/default.d/roboshop.conf
#sed -i -e '/cart/ s/localhost/cart.roboshop.internal/' /etc/nginx/default.d/roboshop.conf
#sed -i -e 's/payment/ /'
#systemctl restart nginx
