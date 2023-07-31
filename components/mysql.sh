source components/common.sh

CHECK_ROOT

if [-z "${MYSQL_PASSWORD}"]; then   ## if MYSQL_PASSWORD is empty then do this #####
  echo "need MYSQL_PASSWORD env variable"
  exit1
fi
echo "Configure YUM Repos"
curl - s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo
CHECK_STAT $?

echo "Install MySQL"
yum install mysql-community-server -y
systemctl enable mysqld && systemctl start mysqld
CHECK_STAT $?

MYSQL_DEFULT_PASSWORD=$(grep 'temporary password' /var/log/mysqld.log | awk'{print $NF}')

echo show databases | mysql -uroot -p"${MYSQL_PASSWORD}" &>>${LOG}
if [$? -ne 0]; then
echo "RESET ROOT PASSWORD"
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"
CHECK_STAT $?
fi

echo show plugins | mysql -uroot -p"${MYSQL_PASSWORD}" | grep validate_password
if [ $? -eq0 ]; then
  echo "uninstall password validate plugin"
  echo "uninstall plugin validate_password;" | mysql -uroot -p"${MYSQL_PASSWORD}
  CHECK_STAT $?
fi

echo "download schema"
curl -s -L -o /tmp/mysql.zip

