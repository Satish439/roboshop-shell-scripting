#!/bin/bash
source components/common.sh
COMPONENT = cart

#CHECK_ROOT
#
#PRINT "settinhs up NodeJS YUM Repo"
#curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG}
#CHECK_STAT $?  #$? here ? is varaible which is going to take as $1 from function##
#
#PRINT NodeJS"
#yum install nodejs -y  &>>${LOG}
#CHECK_STAT $?
#
#PRINT "Creating Application User"
#Useradd roboshop &>>{LOG}
#CHECK_STAT $?
#
#PRINT "Downloading Cart Content"
#curl -s -L -o /tmp/cart.zip "https:github.com/roboshop-devops-project/cart/archive/main.zip" &>>${LOG}
#CHECK_STAT $?
#
#cd /home/roboshop
#
#PRINT "Remove old Content"
#rm -rf cart &>>${LOG}
#CHECK_STAT $?
#
#PRINT "Extart Cart Content"
#unzip /tmp/cart.zip &>>${LOG}
#CHECK_STAT $?
#
#mv Cart-main cart
#cd cart
#
#echo "Install NodeJs Dependencies for Cart Component"
#npm install &>>{LOG}
#CHECK_STAT $?
#
#PRINT "Update SystemD Configuration"
#sed -i -e 's/REDIS_ENDPOINT/redis.roboshop-internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop-internal/' /home/roboshop/systemd.service &>>${LOG}
#CHECK_STAT $?
#
#PRINT "Setup SystemD configuration"
#mv /home/roboshop/cart/systemd.service /etc/system/cart.service &>>{LOG}
#CHECK_STAT $?
#
#systemctl daemon-reload
#systemctl enable cart
#
#echo "Start Cart Service"
#systemctl restart cart &>>{LOG}
#CHECK_STAT $?