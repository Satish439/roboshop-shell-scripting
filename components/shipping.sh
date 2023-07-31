#!/bin/bash
source componets/common.sh
COMPONENT=shipping
MAVEN

#yum install maven -y
#useradd roboshop
#cd /home/roboshop
#
#curl -s -L -o /tmp/shipping.zip "https://github.com/roboshop-devops-projects/shipping/archive/maim.zip"
#unzip /tmp/shipping.zip
#mv shipping-main shipping
#cd shipping
#mvn clean package
#mv target/shipping-1.0.jar shipping.jar
#
#sed -i -e 's/CARTENDPOINT/cart.roboshop.internal/' -e 's/DBHOST/mysql.robodhop.internal/'  /home/roboshop/shipping/systemd.service
#mv /home/roboshop/shipping/systemd.service  /etc/systemd/system/shipping.service
#systemctl darmon-reload
#systemctl start shipping
#
##check it using tail -f var/log/messages  where it will show as JVM is up and running##