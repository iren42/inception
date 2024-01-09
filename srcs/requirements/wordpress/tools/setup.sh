#!/bin/sh
echo "running setup.sh for wordpress"
#chown -R www-data:www-data /var/www/html
#wait until database is ready
sleep 10

#check if wp-config.php exist
if [ -f /var/www/html/wp-config.php ]
then
    echo "wordpress already downloaded"
else
# create a new wp-config.php file
echo "downloading wordpress with cli"
    wp core download --version=6.4.2 --locale=fr_FR --allow-root
echo "config wordpress with cli"
    wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb --allow-root
#    wp db create --allow-root
#    wp core install --url=https://${WP_ADM_USER}.42.fr --title="OLALA" --admin_user=${WP_ADM_USER} --admin_password=${WP_ADM_PASS} --admin_email="${WP_ADM_USER}"@42.fr --allow-root 
    echo "done"
fi
