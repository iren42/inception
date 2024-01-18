#!/bin/bash

set -eo pipefail
echo "running setup.sh for wordpress"

#check if wp-config.php exists or is empty
if [ -s wp-config.php ]; then
    echo "wordpress already downloaded"
else
    echo "config wordpress manual/cli"
    wp config create --path=/var/www/wordpress \
                            --allow-root \
                            --dbname=$MYSQL_DATABASE \
                            --dbuser=$MYSQL_USER \
                            --dbpass=$MYSQL_PASSWORD \
                            --dbhost=$WP_HOST
	# Core installation needs for wordpress and admin user added
    wp core install --path=/var/www/wordpress \
                            --allow-root \
                            --url=$WP_URL \
                          --title=$WP_TITLE \
                          --admin_user=$WP_ADM_USER \
                          --admin_password=$WP_ADM_PASS \
                          --admin_email=$WP_ADM_EMAIL
	# Adds an extra user with no admin permissions
	wp user create --path=/var/www/wordpress \
                            --allow-root \
                          ${WP_USER} \
                          ${WP_USER_EMAIL} \
                          --user_pass=${WP_USER_PASS}
    echo "wordpress is ready"

fi
exec "$@"
