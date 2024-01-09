#!/bin/bash

echo "Setup database"
SQL_FILE=/var/lib/mysql/.setup

# Checks if the Data base with the given name already exists, if so it prints out a message and skips the else step
if [ ! -e $SQL_FILE ];
then 
	echo "Database already exists"
else

service mariadb start

echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;" | mysql -uroot
echo "CREATE USER IF NOT EXISTS $MYSQL_USER@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" | mysql -uroot
echo "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" | mysql -uroot
echo "FLUSH PRIVILEGES;" | mysql -uroot
#echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" | mysql -uroot
touch $SQL_FILE
fi

sleep 2

# stop the service
# but execute it again later
# to make sure all our configurations are set in place
service mariadb stop
