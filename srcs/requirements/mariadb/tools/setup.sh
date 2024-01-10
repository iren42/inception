#!/bin/bash

echo "Setup database"
SQL_FILE=/var/lib/mysql/.dbissetup

# Checks if the Data base with the given name already exists, if so it prints out a message and skips the else step
if [ -d $SQL_FILE ];
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
    echo "database is setup"

    # restart to make sure all our configurations are set in place
    service mariadb stop
    sleep 2
fi

exec mysqld_safe --bind-address=0.0.0.0
