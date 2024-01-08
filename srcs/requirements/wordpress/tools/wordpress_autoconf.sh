#!/bin/sh

#wait until database is ready
sleep 10

#check if wp-config.php exist
if [ -f ./wp-config.php ]
then
    echo "wordpress already downloaded"
else
    wp config create	--allow-root \
       --dbname=$MYSQL_DATABASE \
       --dbuser=$MYSQL_USER \
       --dbpass=$MYSQL_PASSWORD \
       --dbhost=mariadb:3306 --path='/var/www/wordpress'
fi
