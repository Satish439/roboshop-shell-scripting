yum install maven -y
useradd roboshop
cd /home/roboshop
rm -rf shipping
curl -L -o /tmp/shipping-zip "URL"
unzip /tmp/shipping.zip
mv shipping-main shipping
cd shipping
mvn clean package
mv traget/shipping-1.0.jar shipping.jar
sed -i -e 's/CARTENDPOINT/Catalogue.internalroboshop.com' /home/roboshop/systemd.service
sed -i -e 's/DBHOST/mysql.internalrobosshop.com' /home/roboshop/systemd.service
mv /home/roboshop/systemd.service /etc/systemd/system/shipping.service
