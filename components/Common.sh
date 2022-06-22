#!/bin/bash
CHECK_ROOT() {
 USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]
then
  echo you are not a root user
  exit 1
  fi
  }
