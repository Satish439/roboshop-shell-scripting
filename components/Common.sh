#!/bin/bash

CHECK_ROOT() {
  USER_ID=$(id -u)
  if [ $USER_ID -ne 0 ]
  then
    echo you are non root user
    echo -e "\e[31myou should be running this script as root user\e[0m"
    exit 0
    fi
}

## to check the if pervious excuting was Sucess ot Failure##
CHECK_STAT() {
  echo"--------------$1-------------" >>${LOG}
  if [ $1 -ne 0]; then
    echo -e "\e[31mFAILED\e[0m"
    echo -e "\n Check log file - ${LOG} for errors"
    exit2
  else
    echo -e '\e[32mSUCCESS\e[0m"'
    fi
}
### for redirecting output to log file while executing##

LOG=/tmp/roboshop.log
rm -rf $LOG

PRINT() {
  echo"--------------$1-------------" >>${LOG}
  echo '$1'
}

APP_COMMON_SETUP() {

   echo "Creating Application user"
   id roboshop &>>${LOG}
   if [ $? -ne 0 ]; then
     useradd roboshop &>>${LOG}
   fi
   CHECK_STAT $?
   PRINT "Downloading ${COMPONENT} Content"
   curl -s -L -o /tmp/{COMPONENT}.zip "https:github.com/roboshop-devops-project/cart/archive/main.zip" &>>${LOG}
   CHECK_STAT $?

   cd /home/roboshop

   PRINT "Remove old Content"
   rm -rf {COMPONENT} &>>${LOG}
   CHECK_STAT $?

   PRINT "Extart {COMPONENT} Content"
   unzip /tmp/{COMPONENT}.zip &>>${LOG}
   CHECK_STAT $?

}

SYSTEMD(){
  PRINT "Update SystemD Configuration"
  sed -i -e 's/REDIS_ENDPOINT/redis.roboshop-internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop-internal/' /home/roboshop/systemd.service &>>${LOG} && systemctl deamon-reload
  CHECK_STAT $?

  PRINT "Setup SystemD configuration"
  mv /home/roboshop/{COMPONENT}/systemd.service /etc/system/{COMPONENT}.service &>>{LOG}
  CHECK_STAT $?

  PRINT "Start ${COMPONENT} services"
  systemctl enable {COMPONENT} &>>{LOG} && systemctl restart {COMPONENT} &>>{LOG}
  CHECK_STAT $?

}



##Making the common function for all Nodejs applications###

NODEJS() {

  CHECK_ROOT

    PRINT "Setting Up NodeJS YUM Repo"
    curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG}
    CHECK_STAT $?

    PRINT "Installing NodeJS"
    yum install nodejs -y &>>${LOG}
    CHECK_STAT $?

    APP_COMMON_SETUP

    PRINT "Install NodeJS Dependencies for ${COMPONENT} Component"
    mv ${COMPONENT}-main ${COMPONENT} && cd ${COMPONENT} && npm install &>>${LOG}
    CHECK_STAT $?

    SYSTEMD
  }

NGINX() {
  PRINT "Installing   Nginx"
  yum install ngnix -y &>>${LOG}
  CHECK_STAT $?

  PRINT "Download ${COMPONENT} Content"
  curl -s -L -o /tmp/{COMPONENT}.zip "https://githib.com/roboshop-devops-project/${COMPONENT}/archive/main.zip" &>>${LOG}
  CHECK_STAT $?

  PRINT "Clean OLD Content"
  cd /usr/share/ngnix/html
  rm -rf * &>>{LOG}
  CHECK_STAT $?

  PRINT "Extract ${COMPONENT} content"
  unzip /tmp/${COMPONENT}.zip
  CHECK_STAT $?

  PRINT "Configure ${COMPONENT} Content"
  mv ${COMPONENT}-main/* . && mv static/* . && rm -rf ${COMPONENT}-main README.md
  CHECK_STAT $?

  PRINT "update ${COMPONENT} configuration"
  sed -i -e '/catalogue/ s/localhost/catalogue.roboshop.internal/' -e '/user/ s/localhost/user.roboshop.internal/' -e '/cart/ s/localhost/cart.roboshop.internal' -e '/payment/ s/localhost/payment.roboshop.internal' -e '/shipping/ s/localhost/shipping.roboshop.internal/'  /etc/ngnix/default.d/roboshop.conf
  CHECK_STAT $?

  PRINT "Start Ngnix service"
  systemctl enable ngnix &>>{LOG} && systemctl restart ngnix &>>{LOG}
}

MAVEN() {

  CHECK_ROOT

  PRINT "Installing maven"
  yum install maven -y &>>${LOG}
  CHECK_STAT $?

  APP_COMMON_SETUP

  PRINT "Compile ${COMPONENT} code"
  mv ${COMPONENT}-main ${COMPONENT} && cd ${COMPONENT} && mvn clean package &>>${LOG}
  CHECK_STAT $?

  SYSTEMD
}

PYTHON(){
  CHECK_ROOT

  PRINT "Install python 3"
  yum install python36 gcc python3-devel -y &>${LOG}
  CHECK_STAT $?

  APP_COMMON_SETUP

  PRINT "Install ${COMPONENT} Dependenices"
  mv payment-main {COMPONENT}
  cd /home/roboshop/{COMPONENT}
  pip3 install -r requriment.txt

  USER_ID=${id -u roboshop}
  GROUP_ID=${id -g roboshop}

  PRINT"Update ${COMPONENT} Configuration"
  sed -i -e "/^uid/ c uid = ${USER_ID}" -e "/^gid/ c gid = ${GROUP_ID}" /home/robodhop/${COMPONENT}/${COMPONENT}.ini
  CHECK_STAT $?

  SYSTEMD

}


















