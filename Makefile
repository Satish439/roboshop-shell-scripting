#!/bin/bash
frontend:
	bash components/frontend.sh
redis:
	bash components/redis.sh
cart:
	bash components/cart.sh
mongodb:
	bash components/mongodb.sh
catalogue:
	bash components/catalogue.sh
payment:
	bash components/payment.sh
shipping:
	bash components/shipping.sh
user:
	bash components/user.sh
rabbitmq:
	bash components/rabbitmq.sh
mysql:
	bash components/mysql.sh