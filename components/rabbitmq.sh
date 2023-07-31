curl -s https://packagecloud.io/install/repositories/rabbitmq-server/script.rpm.sh |sudo bash
yum install rabbitmq-server -y
systemctl enable rabbitmq-server
