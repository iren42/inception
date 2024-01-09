FROM debian:bullseye

RUN apt update && apt upgrade -y

RUN apt install -y wget \
        php7.4 \
        php-fpm \
        php-mysql \
        mariadb-client
#for debugging purpose
#RUN apt install -y tmux \
#        vim


RUN mkdir -p /var/www/html
RUN chown -R www-data:www-data /var/www/html
RUN chmod 755 /var/www/html


COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/setup.sh /home/
#We go the html directory
WORKDIR /var/www/html/
RUN chmod +x /home/setup.sh

EXPOSE 9000

# php-fpm need a directory to be enabled
RUN mkdir -p /run/php
CMD /bin/bash /home/setup.sh
