


curl - s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo

yum install mysql-community-server -y

systemctl enable mysqld
systemctl start mysql
MYSQL_DEFULT_PASSWORD=$(grep 'temporary password' /var/log/mysqld.log | awk'{print $NF}')

echo

