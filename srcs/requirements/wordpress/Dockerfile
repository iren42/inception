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

RUN wget https://fr.wordpress.org/wordpress-6.4.2-fr_FR.tar.gz -P /var/www

RUN cd /var/www && tar -xzf wordpress-6.4.2-fr_FR.tar.gz && rm wordpress-6.4.2-fr_FR.tar.gz

RUN cp /var/www/wordpress/* /var/www/html
#RUN		chown -R root:root /var/www/html


COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d
#
#RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
#RUN chmod +x wp-cli.phar
#RUN mv wp-cli.phar /usr/local/bin/wp
#
#COPY ./tools/wordpress_autoconf.sh /home/
#RUN chmod +x /home/wordpress_autoconf.sh
#We go the html directory
WORKDIR /var/www/html/
EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.4", "-F"]
