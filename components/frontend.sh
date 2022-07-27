#!/bin/bash

USER_ID=$(id -u)
if[ $USER_ID -ne 0 ]
then
  echo you are non root user
  echo you need to login as root user to execute.
  fi


#To Install Nginx.

yum install nginx -y
systemctl enable nginx
systemctl start nginx

#Let's download the HTDOCS content and deploy under the Nginx path.

curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"

#Deploy in Nginx Default Location.


cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
 rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf

sed -i -e '/catalogue/ s/localhost/catalogue.roboshop.internal/' /etc/nginx/default.d/roboshop.conf
sed -i -e '/user/ s/localhost/user.roboshop.internal/' /etc/nginx/default.d/roboshop.conf
sed -i -e '/cart/ s/localhost/cart.roboshop.internal/' /etc/nginx/default.d/roboshop.conf
sed -i -e 's/payment/ /'
systemctl restart nginx
