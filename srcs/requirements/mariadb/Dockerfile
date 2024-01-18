FROM debian:bullseye

RUN apt update && apt install -y \
        mariadb-server \
       && rm -rf /var/lib/apt/lists/*  

# config file for mariadb
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup.sh

# default directory for mariadb
WORKDIR /var/lib/mysql

# env file is passed to a docker run command
# we do not want the same env for every container
ENTRYPOINT ["setup.sh"]
CMD ["mysqld_safe"]
