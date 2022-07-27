#!/bin/bash

CHECK_ROOT() {
  USER_ID=$(id -u)
  if [ $USER_ID -ne 0 ]
  then
    echo you are non root user
    echo you need to login as root user to execute.
    exit 0
    fi
}
