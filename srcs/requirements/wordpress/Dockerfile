FROM debian:bullseye

RUN apt update && apt upgrade -y

RUN apt install -y wget \
        php7.4 \
        php-fpm \
        php-mysql 
#for debugging purpose
#RUN apt install -y tmux \
#        vim

# /var/www/html is where I want my wordpress files to be
RUN mkdir -p /var/www/html
RUN chown -R www-data:www-data /var/www/html
RUN chmod 755 /var/www/html

# localhost listens to port 9000
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d

# prep wordpress setup
WORKDIR /var/www/html/
COPY ./tools/setup.sh /home
RUN chmod +x /home/setup.sh

# download wp-cli
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

EXPOSE 9000

# php-fpm need a directory to be enabled
RUN mkdir -p /run/php

CMD /bin/bash /home/setup.sh
