#!/bin/sh
echo "running setup.sh for wordpress"
#chown -R www-data:www-data /var/www/html
#wait until database is ready
#sleep 10

#check if wp-config.php exist
if [ -f /var/www/html/wp-config.php ]
then
    echo "wordpress already downloaded"
else
    # create a new wp-config.php file
    echo "downloading wordpress with cli"
    wp core download --version=6.4.2 --locale=fr_FR --allow-root
    
    echo "config wordpress with cli"
    # Import env variables in the config file
    cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
	sed -i "s/votre_nom_de_bdd/$MYSQL_DATABASE/g" wp-config.php
	sed -i "s/votre_utilisateur_de_bdd/$MYSQL_USER/g" wp-config.php
	sed -i "s/votre_mdp_de_bdd/$MYSQL_PASSWORD/g" wp-config.php
	sed -i "s/localhost/$MYSQL_HOST/g" wp-config.php
	# Core installation needs for wordpress and admin user added
#	wp core install --allow-root --url=${WP_URL} --title=${WP_TITLE} --admin_user=${WP_ADM_USER} --admin_password=${WP_ADM_PASS} --admin_email=${WP_ADM_EMAIL}
	# Adds an extra user with no admin permissions
#	wp user create --allow-root ${WP_USER} ${WP_USER_EMAIL} --user_pass=${WP_USER_PASS};
#    wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb:3306 --allow-root
#    wp core install --url=https://${WP_ADM_USER}.42.fr --title="OLALA" --admin_user=${WP_ADM_USER} --admin_password=${WP_ADM_PASS} --admin_email="${WP_ADM_USER}"@42.fr --allow-root 
    echo "done"
fi
exec /usr/sbin/php-fpm7.4 -F
