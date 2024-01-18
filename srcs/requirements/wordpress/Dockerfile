FROM debian:bullseye

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
#RUN groupadd -r www-data && useradd -r -g www-data www-data --home-dir /var/www/wordpress

RUN \
        apt update && apt install -y \
        wget \
        php7.4 \
        php-fpm \
        php-mysql \
       && rm -rf /var/lib/apt/lists/*;

# download wordpress and wp-cli
WORKDIR /var/www

RUN \
    wget https://fr.wordpress.org/wordpress-6.4.2-fr_FR.tar.gz -P /var/www \
    && tar -xzf wordpress-6.4.2-fr_FR.tar.gz && rm wordpress-6.4.2-fr_FR.tar.gz \
    && wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# gives the address on which to accept fastcgi requests (port 9000)
# and give permissions to exec php-fpm to www-data
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d


# /var/www/wordpress is where I want my wordpress files to be
# php-fpm need a directory to be enabled
RUN mkdir -p /var/www/wordpress \
    && chown -R www-data:www-data /var/www/wordpress \
    && chmod 775 /var/www/wordpress; \
    mkdir -p /run/php



COPY ./tools/setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup.sh
WORKDIR /var/www/wordpress/


EXPOSE 9000
ENTRYPOINT ["/usr/local/bin/setup.sh"]
CMD ["/usr/sbin/php-fpm7.4", "-F"]
