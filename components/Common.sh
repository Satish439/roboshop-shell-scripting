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
  if [ $? -ne 0]; then
    echo -e "\e[31mFAILED\e[0m"
    echo -e "\n Check log file - ${LOG} for errors"
    exit2
  else
    echo Sucess
    fi
}
### for redirecting output to log file while executing##

LOG=/tmp/roboshop.log
rm -rf $LOG

APP_COMMON_SETUP


##Making the common function for all Nodejs applications###

NODEJS() {

  CHECK_ROOT

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
  PRINT "Instsalling Nginx"


}
