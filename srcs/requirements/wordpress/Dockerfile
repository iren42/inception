FROM debian:bullseye

RUN \
        apt-get update && apt-get install -y \
        wget \
        php7.4 \
        php-fpm \
        php-mysql \
#      gosu \
       && rm -rf /var/lib/apt/lists/*;
#        gosu nobody true

# download wordpress and wp-cli
WORKDIR /var/www

RUN \
    wget https://fr.wordpress.org/wordpress-6.4.2-fr_FR.tar.gz -P /var/www \
    && tar -xzf wordpress-6.4.2-fr_FR.tar.gz && rm wordpress-6.4.2-fr_FR.tar.gz \
    && wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Add local user 'dev'
RUN groupadd -r dev --gid=9001 && useradd -r -g dev --uid=9001 dev \
    && usermod -aG dev www-data
# Grant him sudo privileges
#RUN mkdir -p /etc/sudoers.d/ && echo "dev ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/dev && \
#    chmod 0440 /etc/sudoers.d/dev

# php-fpm conf file gives the address on which to accept fastcgi requests (port 9000)
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d

# I could not disable the error.log for php-fpm
# so, I created the error.log file for php-fpm to be able to write on it
RUN touch /var/log/error.log;  \
    chown -R dev:dev /var/log/ \
    && chmod 660 /var/log/error.log; \
    chown -R dev:dev /var/www/wordpress \
    && chmod 755 /var/www/wordpress; \
    mkdir -p /run/php \
    && chown -R dev:dev /run/php
# php-fpm need the directory /run/php to create its PID file

# it's good practice to make root the owner of the entrypoint.sh
COPY --chown=root ./tools/setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup.sh 
WORKDIR /var/www/wordpress/


EXPOSE 9000
# make it impossible to run a container as root
RUN chsh -s /usr/sbin/nologin root
USER dev
ENTRYPOINT ["/usr/local/bin/setup.sh"]
CMD ["/usr/sbin/php-fpm7.4", "-F"]
