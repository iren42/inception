#!/bin/bash

set -eo pipefail
echo "Setup database"
#SQL_FILE=/var/lib/mysql/.dbissetup

# Checks if the database already exists, if so it prints out a message and skips the else step
if [ -d "$MYSQL_DATABASE" ];
then 
	echo "Database already exists"
else

    service mariadb start

    echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;" | mysql
    echo "CREATE USER IF NOT EXISTS $MYSQL_USER@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" | mysql
    echo "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" | mysql
    echo "FLUSH PRIVILEGES;" | mysql
# password protect mariadb root
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" | mysql
    echo "database is setup"

    # restart to make sure all our configurations are set in place
    mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown
    sleep 2
fi

exec $@
